// Params //
// Number of curve points (higher = smoother)
float N;
float r; 
float ns = 0.7;
float d;
int n_seeds = 10;
PVector[] seeds;

void setup()
{
	size(600,600);
	
	N = 100;
	r = width/2;
	
	update_seeds();
}

void draw()
{
	background(255);
	noStroke();

	float time = 0.0001*millis();

	fill(50);

	for(int i = 0; i < seeds.length; i++)
	{
		if(i%2 == 0)
			fill(50);
		else
			fill(255);
		
		blob(seeds[i].x, seeds[i].y, seeds[i].z, time, ns, false);
		blob(width-seeds[i].x, seeds[i].y, seeds[i].z, time, ns, true);
	}
}

// Draws a blob
// (cx, cy): blob center
// r: blob radius
// time: time parameter for the noise function
// inv: whether to mirror the blob
void blob(float cx, float cy, float r, float time, float ns, boolean inv)
{
	beginShape();
	float a = PI/2;
	for(float i = 0; i <= N+1; i++)
	{
		float x = cx+r*cos(a);
		float y = cy+r*sin(a);
		a += TWO_PI/N;

		float b = TWO_PI*i/(N+1);
		if(inv)
		{
			b = TWO_PI - b;
		}

		float s = noise(ns*(10+cos(b)), ns*(10+sin(b)), time);
		curveVertex(cx+s*(x-cx), cy+s*(y-cy));
	}
	endShape();
}

// Procedure to update the parameters of the small blobs (centers and radii)
void update_seeds()
{
	seeds = new PVector[n_seeds];
	seeds[0] = new PVector(width/2, height/2, width/2);
	for(int i = 1; i < 10; i++)
	{
		float cx = random(0,width/2);
		float cy = random(0,height/2);
		float r = random(0,width/2);
		seeds[i] = new PVector(cx,cy,r);
	}
}

void mouseClicked()
{
	saveFrame("prints/###.png");
	update_seeds();
}
