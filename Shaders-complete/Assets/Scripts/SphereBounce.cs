using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SphereBounce : MonoBehaviour
{
	float startY;

    // Start is called before the first frame update
    void Start()
    {
		startY = transform.position.y;
    }

    // Update is called once per frame
    void Update()
    {
		Vector3 pos = transform.position;
		pos.y = startY + (float)(Math.Sin(Time.time*3.0) * 0.2);
		transform.position = pos;
    }
}
