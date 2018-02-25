Return-Path: virtio-return-2911-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Sun, 25 Feb 2018 20:43:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180225204144-mutt-send-email-mst@kernel.org>
References: <20180216092050-mutt-send-email-mst@kernel.org>
 <ee4e36ca-8eba-8ba4-84c5-ccc65ce1f641@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee4e36ca-8eba-8ba4-84c5-ccc65ce1f641@linux.vnet.ibm.com>
Subject: [virtio] Re: [PATCH v8 00/16] packed ring layout spec
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 16, 2018 at 02:22:21PM +0100, Halil Pasic wrote:
> 
> 
> On 02/16/2018 08:20 AM, Michael S. Tsirkin wrote:
> > This addresses comments on v7. A compiled version can
> > be found under https://github.com/oasis-tcs/virtio-docs.git
> > 
> > virtio-v1.1-packed-wd08-diff.pdf  virtio-v1.1-packed-wd08.pdf
> > 
> > for redline and clean versions, respectively.
> > 
> > Note: please do not try to edit the pdf and post comments
> > in the edited file. Please post comments in a text
> > format, as pdfs are not archived with the list.
> > 
> > TODO: support for actual passthrough devices will likely
> > require more new features, such as requirement for
> > stronger memory barriers.
> > 
> > Thanks to everyone who commented! You know who you are.
> > 
> > changes from v7:
> > - new notitfication_data feature, supported for all
> >   transports and formats
> > - addressed all outstanding comments
> 
> I don't agree about 'addressed all outstanding comments'. Should
> Remind you about the not addressed comments I find important in the
> v7 thread, or should I repeat the comments here?
> 
> Regards,
> Halil

There were suggestions for improving the spec generally,
improving wording already present in the spec.
I was under the impression that we agreed to address this
separately from this proposal.

Let me know if that's not the case.

-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

