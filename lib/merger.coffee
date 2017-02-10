
_ = require 'lodash'
fs = require 'fs'
Path = require 'path'
Canvas = require 'canvas-prebuilt'
Image = Canvas.Image

debug = require('debug')('spritemerge')

PNG_REGEXP = /\.png$/i

argv = process.argv.slice(2)

if argv.length < 2
	console.log 'Usage:\n    spritemerge <IMAGE FOLDER PATH> <PNG OUTPUT PATH>'
	process.exit 1

[sourceFolderPath,targetImagePath] = argv

console.log 'Using source folder:',sourceFolderPath

folderContent = fs.readdirSync sourceFolderPath
folderContent = _.filter folderContent, (name)-> PNG_REGEXP.test name
folderContent.sort()

debug 'Found png images:',folderContent.length

resultCanvas = null
canvasContext = null
frameCount = folderContent.length
frameHeight = null
frameWidth = null

for file,index in folderContent
	filePath = Path.join sourceFolderPath,file
	currentImage = new Image
	currentImage.src = filePath

	if resultCanvas is null
		frameWidth = currentImage.width
		frameHeight = currentImage.height
		resultCanvas = new Canvas  frameWidth*frameCount,frameHeight
		canvasContext = resultCanvas.getContext '2d'
		debug 'Result image created.'

	debug '>>',index,file

	canvasContext.drawImage currentImage,0,0,frameWidth,frameHeight,index*frameWidth,0,frameWidth,frameHeight

debug 'images processed.'
imageBuffer = resultCanvas.toBuffer()

fs.writeFile targetImagePath,imageBuffer
