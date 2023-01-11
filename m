Return-Path: <pasic@linux.ibm.com>
Date: Wed, 11 Jan 2023 21:46:37 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Message-ID: <20230111214637.68bec904.pasic@linux.ibm.com>
In-Reply-To: <1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
	<20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
	<20230110233401.131cc97a.pasic@linux.ibm.com>
	<1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 11 Jan 2023 19:08:53 +0800
Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> > > +\subsection{Permissions}\label{sec:Device Types / Network Device / Device Operation / Permission}
> > > +
> > > +The permissions of a ism region determine whether this ism region can be
> > > +attached and the read and write permissions after attach.
> > > +
> > > +The driver can set the default permissions, or set permissions for some certain
> > > +devices.  
> >
> > What does "default permissions" and "some certain devices" mean here?  
> 
> "default permissions": This can be understood as the permissions for all devices.
> "some certain devices": This is the permissions set for a specific device.

This is IMHO to far where you discuss the permission model and make some
normative statements about it (in 5.20.8.4 Grant ISM Region).

BTW in my opinion that part needs some more work as well. For example if
the "default" permission is permissive, but the permission specifically
set for the device attempting the operation it ain't clear what happens.
I may end up commenting some more on these at when reviewing that part.


