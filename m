Return-Path: virtio-return-2876-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-1-git-send-email-mst@redhat.com>
 <db5515bb-5995-011a-6e84-c2194dedf2aa@linux.vnet.ibm.com>
 <20180206020102-mutt-send-email-mst@kernel.org>
 <ffb4c3fc-9f72-3b58-9d17-fcef906d3805@linux.vnet.ibm.com>
 <20180206122055.40550c4a.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 6 Feb 2018 13:03:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180206122055.40550c4a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <7bc047b0-5eb1-1f31-81ed-4cb5e61ed4b7@linux.vnet.ibm.com>
Subject: Re: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v7 01/11] content:
 move 1.0 queue format out to a separate section
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 02/06/2018 12:20 PM, Cornelia Huck wrote:
> On Tue, 6 Feb 2018 12:10:20 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 02/06/2018 01:05 AM, Michael S. Tsirkin wrote:
>>> On Mon, Feb 05, 2018 at 11:54:52PM +0100, Halil Pasic wrote:  
[..]
>> In the CIO transport we have an explicit mention of virtio 1.0 (explains
>> revision 1). I wonder if that is still appropriate. Shouldn't that just
>> be virtio 1?
> 
> We can certainly do s/1.0/1/ in the ccw transport (mind doing a patch?)
> 

Will do.

> For the greater picture: As I see it, any implementation conforming to
> 1.1 is also conforming to 1.0. To conform to 1.1, it only needs the
> split layout. I think we can continue with that for any further
> iterations of 1.n (and keep VERSION_1 as it is now.)
>

Agreed. I will think a bit if there is an elegant way to codify this in
the spec.
 
> What we want to do with version 2.n (should that ever come up) is up
> for discussion (can an implementation conform to version 2 but not to
> version 1?). But I prefer to cross that bridge when we come to it.
> 

I agree. There is no reason to ponder about this right now.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

