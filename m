Return-Path: virtio-return-2910-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 16 Feb 2018 18:02:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180216180258.169de0d7.cohuck@redhat.com>
In-Reply-To: <20180216092050-mutt-send-email-mst@kernel.org>
References: <20180216092050-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v8 00/16] packed ring layout spec
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Feb 2018 09:20:50 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> This addresses comments on v7. A compiled version can
> be found under https://github.com/oasis-tcs/virtio-docs.git
> 
> virtio-v1.1-packed-wd08-diff.pdf  virtio-v1.1-packed-wd08.pdf
> 
> for redline and clean versions, respectively.
> 
> Note: please do not try to edit the pdf and post comments
> in the edited file. Please post comments in a text
> format, as pdfs are not archived with the list.
> 
> TODO: support for actual passthrough devices will likely
> require more new features, such as requirement for
> stronger memory barriers.
> 
> Thanks to everyone who commented! You know who you are.
> 
> changes from v7:
> - new notitfication_data feature, supported for all
>   transports and formats
> - addressed all outstanding comments

I'm basically fine with this. Only minor things.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

