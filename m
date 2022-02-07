Return-Path: <mst@redhat.com>
Date: Mon, 7 Feb 2022 11:19:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
Message-ID: <20220207111910-mutt-send-email-mst@kernel.org>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <87tudgw0yi.fsf@redhat.com>
 <df605f77-9623-45c3-f340-1a36fadec3b0@nvidia.com>
 <20220207052554-mutt-send-email-mst@kernel.org>
 <87a6f2x5c7.fsf@redhat.com>
 <c4258e9b-4a9b-9320-cbea-6a38bbc7f7b0@nvidia.com>
 <87y22mvhmu.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87y22mvhmu.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 07, 2022 at 04:08:41PM +0100, Cornelia Huck wrote:
> On Mon, Feb 07 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> 
> > On 2/7/2022 1:51 PM, Cornelia Huck wrote:
> >> On Mon, Feb 07 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>
> >>> On Mon, Feb 07, 2022 at 12:14:33PM +0200, Max Gurtovoy wrote:
> >>>> On 2/3/2022 3:09 PM, Cornelia Huck wrote:
> >>>>> On Thu, Feb 03 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>>>> +commands to manipulate various features of the device and/or to manipulate
> >>>>>> +various features, if possible, of another device within the same group (e.g. PCI VFs
> >>>>> Maybe add
> >>>>>
> >>>>> "Which devices are actually considered a group is transport specific."
> >>>>>
> >>>>> ?
> >>>> Not sure we want to restrict ourselves for that.
> >>> do restrict this please, if we want to extend the scope we can
> >>> always do that down the road.
> >> I'm also not sure how grouping can _not_ be transport specific... the
> >> PF/VF example is obviously a pci thing; for ccw, in a non-virtio
> >> context, there's sometimes the concept of some subchannels/devices being
> >> grouped together with no clear hierarchy, and for mmio, I don't really
> >> have an idea how "grouping" might work there.
> >
> > Yes today it's transport specific.
> >
> > But if one day there will be a definition for virtio fabric (over 
> > TCP/RDMA) it might not be true.
> 
> I don't think that is contadictory; we can simply extend the meaning of
> what "grouping" means when needed.

Yes but as long it is transport specific I don't see why not
call this out.

-- 
MST

