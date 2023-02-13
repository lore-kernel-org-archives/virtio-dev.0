Return-Path: <mst@redhat.com>
Date: Mon, 13 Feb 2023 03:16:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 03/10] admin: introduce group administration commands
Message-ID: <20230213031358-mutt-send-email-mst@kernel.org>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
 <PH0PR12MB54817D14FBFDD561D8BCDF7EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230212044245-mutt-send-email-mst@kernel.org>
 <af4f4530-406f-cc30-748f-94ee916a6b8a@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <af4f4530-406f-cc30-748f-94ee916a6b8a@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 13, 2023 at 02:54:47AM +0200, Max Gurtovoy wrote:
> > For some system calls and library functions (e.g.,
> >         getpriority(2)), -1 is a valid return on success.  In such cases,
> >         a successful return can be distinguished from an error return by
> >         setting errno to zero before the call, and then, if the call
> >         returns a status that indicates that an error may have occurred,
> >         checking to see if errno has a nonzero value.
> > 
> > 
> > 
> > > Description is already good enough to describe what they are.
> > > Can we please drop Linux wording?
> > 
> > But why should we? It's where 22 comes from so this way people are not
> > wondering about the value, and it's somewhat helpful for Linux
> > developers.
> > 
> 
> I also think we should not mention Linux. I don't think it's mentioned
> currently in the spec and no good reason to do so now.

But we do: fuse, input at least both do.

> Also value of 22 is not mandatory for this EINVAL status code. It can be
> just 1 (the first number after the OK status).

22 makes it a tiny bit easier for kvm. So why not.

> Developers should be able to read the specification and find out the meaning
> of error code.

I think the text does that. 

-- 
MST

