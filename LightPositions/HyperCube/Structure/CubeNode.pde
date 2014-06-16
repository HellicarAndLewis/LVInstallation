//equivalent of a vertex in a meshclass
class CubeNode {
  //topology
  //the diagonal
  CubeEdge transferEdge;
  //for every node there is an edge in the X, Y and Z directions
  CubeEdge edgeX;
  CubeEdge edgeY;
  CubeEdge edgeZ;
  
  //world position
  PVector position;
  
  //constructor
  CubeNode() {
  }
}
