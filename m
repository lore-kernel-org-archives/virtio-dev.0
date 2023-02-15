Return-Path: <mst@redhat.com>
Date: Wed, 15 Feb 2023 00:13:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 03/10] admin: introduce group administration commands
Message-ID: <20230215001255-mutt-send-email-mst@kernel.org>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
 <PH0PR12MB54817D14FBFDD561D8BCDF7EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230212044245-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F96BC5CCD806210F13D9DCA29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230214014634-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548103071F8E12DC67020800DCA29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230214164846-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813924C62D69DE3BB2002EDCA39@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813924C62D69DE3BB2002EDCA39@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 15, 2023 at 04:46:26AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, February 14, 2023 4:58 PM
> 
> > > > > 1. If we start putting 22 with Linux annotations, in few weeks
> > > > > virtio Net device
> > > > section will be full of annotation of ethtool, tc, ip config and
> > > > more for Linux developers.
> > > > > For example, the current two interrupt moderation patches need to
> > > > > write
> > > > ethtool options details to match to following this Linux example here.
> > > This cannot be relaxed if errno.h and Linux annotation must be added.
> > 
> > I dont really know what does this mean.
> >
> It means why should Linux annotation is limited to error codes of AQ.
> Why not annotate Linux for other areas of the spec such as ethtool annotation for interrupt moderation.

If it is relevant somehow, bring it in.

> > > And I don't think its correct direction for the spec.
> > >
> > > > > It is better to avoid such things and keep spec OS agnostics, even
> > > > > though it is
> > > > addressing and fitting into the Linux use cases.
> > > > >
> > > > > 2. Virtio error code to Linux error code switch-case is simple routine to
> > have.
> > > > >
> > > > > 3. Every time virtio spec to refer to errno.h for finding right
> > > > > value is opposite
> > > > of what spec may want to achieve.
> > > > > If an error code doesn't match to errno.h, now spec developers and
> > > > > reviewers
> > > > to review what is not defined by errno.h to find as unique value.
> > > > >
> > > > > 3.1 And if that is taken in future by errno.h for something else?
> > > > >
> > > > > All of this is not worth a simple switch case statement to deal with.
> > > >
> > > > I think we'll have to agree to disagree here. Years working on virt
> > > > taught me that matching some existing interface is usually better
> > > > than coming up with our own.
> > > With all due respect to your working experience on virt, learning from existing
> > technology, standards, and open-source software is certainly good.
> > 
> > Glad we agree on this...
> > 
> > > However, it is a not correct to imply that virtio community will make mistake if
> > they do not copy error codes from the errno.h file for AQ.
> > 
> > unfortunately you seem not to follow this to the logical conclusion.
> > 
> > > > Even if it is a bit more work upfront it pays dividends later.
> 
> > > If virtio is copying GPLv2 errno.h error codes, it must be spelled out in
> > licensing area and generic line as errno.h and not just "Linux".
> > > I don't think this is right for virtio spec.
> > 
> > Neither EINVAL nor the value 22 are under GPL in any way.
> >
> I referred to [1] https://elixir.bootlin.com/linux/latest/source/include/uapi/asm-generic/errno-base.h#L26
> And missed the sycall note at start.
> Thanks for the clarification.
> 
> > 
> > > > And yes we can come up with crazy conventions like 0xdead for success.
> > > > Does not mean we should.
> > > The question is: Can virtio community define error codes by learning from
> > errno.h, netlink errors and by learning from other industry leading specs?
> > > I think yes, community members in this email thread can do that without
> > annotating Linux in the spec.
> > >
> > > My humble request is, let's spend more time to solidify the AQ on other
> > aspects than copying error codes.
> > 
> > Yea I have no idea why you are wasting your and my time on this either.
> > Repeating the same thing over and over will not make it right. And no we do not
> > need more arguments either.
> 
> Not sure what was repeated...
> 
> Anyways, if you have so strong preference to use the derivative work of "Linux", 
> please add the stable link of it the section 1.1 or 1.2 references sections and refer to it in the text.
> This will make things crystal clear for the source of existing and future error codes.

Yea that makes sense.

-- 
MST

