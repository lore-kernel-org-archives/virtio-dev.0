Return-Path: virtio-return-2875-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 6 Feb 2018 12:20:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180206122055.40550c4a.cohuck@redhat.com>
In-Reply-To: <ffb4c3fc-9f72-3b58-9d17-fcef906d3805@linux.vnet.ibm.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-1-git-send-email-mst@redhat.com>
	<db5515bb-5995-011a-6e84-c2194dedf2aa@linux.vnet.ibm.com>
	<20180206020102-mutt-send-email-mst@kernel.org>
	<ffb4c3fc-9f72-3b58-9d17-fcef906d3805@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v7 01/11]
 content: move 1.0 queue format out to a separate section
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 6 Feb 2018 12:10:20 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 02/06/2018 01:05 AM, Michael S. Tsirkin wrote:
> > On Mon, Feb 05, 2018 at 11:54:52PM +0100, Halil Pasic wrote:  
> >>
> >>
> >> On 01/23/2018 01:01 AM, Michael S. Tsirkin wrote:  
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

> >>> +\section{Split Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Split Virtqueues}
> >>> +The split virtqueue format is the original format used by legacy
> >>> +virtio devices.  
> >>
> >> All v1.0 devices and drivers are using split too not only legacy (aka pre v1.0).   
> > 
> > Yes but there's no versioning in virtio. IOW there is not need to
> > introduce a concept of "1.0 device". Devices just either do or
> > do not support the packed format.
> >  
> 
> 
> I agree with what Connie proposed (drop 'used by legacy virtio devices').
> My point is that this legacy can lead to confusion.
> 
> Regarding no versioning in virtio: I agree only partially. We have
> the VIRTIO_F_VERSION_1 feature bit and we have a version number in
> the title. But I think, I understand what you mean. This non-egsistence
> of versioning in virtio is probably trivial for anybody working on
> virtio for years. But is it for a new hire who just got trough the spec?
> 
> In the CIO transport we have an explicit mention of virtio 1.0 (explains
> revision 1). I wonder if that is still appropriate. Shouldn't that just
> be virtio 1?

We can certainly do s/1.0/1/ in the ccw transport (mind doing a patch?)

For the greater picture: As I see it, any implementation conforming to
1.1 is also conforming to 1.0. To conform to 1.1, it only needs the
split layout. I think we can continue with that for any further
iterations of 1.n (and keep VERSION_1 as it is now.)

What we want to do with version 2.n (should that ever come up) is up
for discussion (can an implementation conform to version 2 but not to
version 1?). But I prefer to cross that bridge when we come to it.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

