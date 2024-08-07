<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dream Home Architect</title>
    <style>
        body { margin: 0; }
        canvas { display: block; }
        #ui { position: absolute; top: 10px; left: 10px; }
    </style>
</head>
<body>
    <div id="ui">
        <button id="addRoom">Add Room</button>
        <button id="addFurniture">Add Furniture</button>
        <button id="changeWallColor">Change Wall Color</button>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="game.js"></script>
</body>
</html>let scene, camera, renderer, controls;
let house = { rooms: [] };

function init() {
    // Create scene
    scene = new THREE.Scene();
    scene.background = new THREE.Color(0xskyblue);

    // Create camera
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.set(0, 5, 10);

    // Create renderer
    renderer = new THREE.WebGLRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(renderer.domElement);

    // Add lights
    const ambientLight = new THREE.AmbientLight(0x404040);
    scene.add(ambientLight);
    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.5);
    directionalLight.position.set(1, 1, 1);
    scene.add(directionalLight);

    // Add ground
    const groundGeometry = new THREE.PlaneGeometry(20, 20);
    const groundMaterial = new THREE.MeshStandardMaterial({ color: 0x00ff00 });
    const ground = new THREE.Mesh(groundGeometry, groundMaterial);
    ground.rotation.x = -Math.PI / 2;
    scene.add(ground);

    // Add event listeners
    document.getElementById('addRoom').addEventListener('click', addRoom);
    document.getElementById('addFurniture').addEventListener('click', addFurniture);
    document.getElementById('changeWallColor').addEventListener('click', changeWallColor);

    // Start animation loop
    animate();
}

function addRoom() {
    const roomGeometry = new THREE.BoxGeometry(3, 2, 3);
    const roomMaterial = new THREE.MeshStandardMaterial({ color: 0xffffff });
    const room = new THREE.Mesh(roomGeometry, roomMaterial);
    room.position.set(house.rooms.length * 3, 1, 0);
    scene.add(room);
    house.rooms.push(room);
}

function addFurniture() {
    if (house.rooms.length === 0) return;
    const furnitureGeometry = new THREE.BoxGeometry(0.5, 0.5, 0.5);
    const furnitureMaterial = new THREE.MeshStandardMaterial({ color: 0x964B00 });
    const furniture = new THREE.Mesh(furnitureGeometry, furnitureMaterial);
    const lastRoom = house.rooms[house.rooms.length - 1];
    furniture.position.copy(lastRoom.position);
    furniture.position.y += 0.5;
    scene.add(furniture);
}

function changeWallColor() {
    if (house.rooms.length === 0) return;
    const lastRoom = house.rooms[house.rooms.length - 1];
    lastRoom.material.color.setHex(Math.random() * 0xffffff);
}

function animate() {
    requestAnimationFrame(animate);
    renderer.render(scene, camera);
}

function onWindowResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
}

window.addEventListener('resize', onWindowResize, false);

init();
