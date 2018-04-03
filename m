Return-Path: virtio-return-3044-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 3 Apr 2018 16:32:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180403163253.29d207d3.cohuck@redhat.com>
In-Reply-To: <28a35397-b62a-0c5d-ad77-c8a6f308dd5f@linux.vnet.ibm.com>
References: <1522168507-58698-1-git-send-email-mst@redhat.com>
	<94d79449-4d96-82b5-f046-f5bf6c47a7bb@linux.vnet.ibm.com>
	<20180328200739-mutt-send-email-mst@kernel.org>
	<20180329110555.708a88b9.cohuck@redhat.com>
	<c5dd1c7e-30e6-119e-d06b-fc8cee0d671c@linux.vnet.ibm.com>
	<20180329171705-mutt-send-email-mst@kernel.org>
	<28a35397-b62a-0c5d-ad77-c8a6f308dd5f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v12]
 VIRTIO_F_NOTIFICATION_DATA: extra data to devices
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 2 Apr 2018 17:34:50 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 03/29/2018 04:30 PM, Michael S. Tsirkin wrote:
> > On Thu, Mar 29, 2018 at 04:15:19PM +0200, Halil Pasic wrote:  
> >>  
> [..]
> >>
> >> I don't have a good solution, otherwise I would have proposed already.
> >> Maybe something like 'available notification' and 'used notification' is
> >> worth considering. I don't like that one can read available and used
> >> as normal English (that is a notification that is available and not
> >> a notification that buffers were made available at the given virtqueue).  
> > 
> > I think I like this.
> > 
> > Available buffer / used buffer notifications?
> >   
> 
> I will do it!
> @Connie: if you have concerns or something even better in mind
> please do tell.

No further comments from me.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

