Return-Path: virtio-return-2873-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 6 Feb 2018 09:38:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180206093849.6c269d41.cohuck@redhat.com>
In-Reply-To: <20180206020102-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-1-git-send-email-mst@redhat.com>
	<db5515bb-5995-011a-6e84-c2194dedf2aa@linux.vnet.ibm.com>
	<20180206020102-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v7 01/11] content: move 1.0 queue format out to
 a separate section
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 6 Feb 2018 02:05:11 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Feb 05, 2018 at 11:54:52PM +0100, Halil Pasic wrote:
> > 
> > 
> > On 01/23/2018 01:01 AM, Michael S. Tsirkin wrote:  

> > > +\section{Split Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Split Virtqueues}
> > > +The split virtqueue format is the original format used by legacy
> > > +virtio devices.  
> > 
> > All v1.0 devices and drivers are using split too not only legacy (aka pre v1.0).   
> 
> Yes but there's no versioning in virtio. IOW there is not need to
> introduce a concept of "1.0 device". Devices just either do or
> do not support the packed format.

Maybe just drop "used by legacy virtio devices"?

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

