Return-Path: virtio-dev-return-3307-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E51015819139
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2018 13:23:47 -0800 (PST)
Date: Tue, 27 Feb 2018 23:23:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180227231731-mutt-send-email-mst@kernel.org>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180220104224.GA2031@nanopsycho>
 <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180227084959.GB2005@nanopsycho>
 <CAKgT0Ucp8WhkORpVVy2VWwuvxZHZjXKn6YfHfVaLAVVybf3t5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ucp8WhkORpVVy2VWwuvxZHZjXKn6YfHfVaLAVVybf3t5w@mail.gmail.com>
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 27, 2018 at 01:16:21PM -0800, Alexander Duyck wrote:
> The other thing I am looking at is trying to find a good way to do
> dirty page tracking in the hypervisor using something like a
> para-virtual IOMMU. However I don't have any ETA on that as I am just
> starting out and have limited development time. If we get that in
> place we can leave the VF in the guest until the very last moments
> instead of having to remove it before we start the live migration.
> 
> - Alex

I actually think your old RFC would be a good starting point:
https://lkml.org/lkml/2016/1/5/104

What is missing is I think enabling/disabling dynamically.

Seems to be easier than tracking by the hypervisor.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

