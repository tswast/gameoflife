// Copyright 2016 Google Inc.
// Use of this source code is governed by the Apache 2.0
// license that can be found in the LICENSE file.

package cell

import (
	"reflect"
	"testing"
	"time"
)

var runTests = [][][][]uint32{
	// http://www.conwaylife.com/wiki/Glider
	{
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 1, 0, 0, 0},
			{0, 0, 0, 1, 0, 0},
			{0, 1, 1, 1, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 1, 0, 1, 0, 0},
			{0, 0, 1, 1, 0, 0},
			{0, 0, 1, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 1, 0, 0},
			{0, 1, 0, 1, 0, 0},
			{0, 0, 1, 1, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 1, 0, 0, 0},
			{0, 0, 0, 1, 1, 0},
			{0, 0, 1, 1, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 1, 0, 0},
			{0, 0, 0, 0, 1, 0},
			{0, 0, 1, 1, 1, 0},
			{0, 0, 0, 0, 0, 0},
		},
	},
	// http://www.conwaylife.com/wiki/Blinker
	{
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 1, 1, 1, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 1, 0, 0, 0},
			{0, 0, 1, 0, 0, 0},
			{0, 0, 1, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 1, 1, 1, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
	},
	// http://www.conwaylife.com/wiki/Beehive
	{
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 1, 1, 0, 0},
			{0, 1, 0, 0, 1, 0},
			{0, 0, 1, 1, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
		{
			{0, 0, 0, 0, 0, 0},
			{0, 0, 1, 1, 0, 0},
			{0, 1, 0, 0, 1, 0},
			{0, 0, 1, 1, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
	},
	{
		{
			{0, 0, 0, 0, 0, 0},
			{1, 1, 0, 0, 0, 0},
			{0, 0, 1, 0, 0, 1},
			{1, 1, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
		{
			{0, 0, 0, 0, 0, 0},
			{1, 1, 0, 0, 0, 0},
			{0, 0, 1, 0, 0, 1},
			{1, 1, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0},
		},
	},
}

func TestRun(t *testing.T) {
	for _, s := range runTests {
		tick := make(chan time.Time)
		defer close(tick)
		c := fromArray(s[0])
		r := Run(c, tick)
		prev := c
		for _, want := range s[1:] {
			tick <- time.Time{}
			got := <-r
			cwant := fromArray(want)
			if !reflect.DeepEqual(got, cwant) {
				t.Errorf(
					"Got state %#v from previous state %#v, want %#v",
					got,
					prev,
					cwant)
			}
			prev = got
		}
	}
}

func fromArray(a [][]uint32) *Field {
	h := len(a)
	w := len(a[0])
	c := NewField(w, h)

	for y, row := range a {
		for x, s := range row {
			c.State[y*int(w)+x] = s
		}
	}
	return c
}
