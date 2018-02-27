Return-Path: virtio-dev-return-3308-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 05C5A58191BD
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2018 13:30:17 -0800 (PST)
Date: Tue, 27 Feb 2018 23:30:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180227232437-mutt-send-email-mst@kernel.org>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180220104224.GA2031@nanopsycho>
 <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180227084959.GB2005@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227084959.GB2005@nanopsycho>
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 27, 2018 at 09:49:59AM +0100, Jiri Pirko wrote:
> Now the question is: is it possible to merge the demands you have and
> the generic needs I described into a single solution? From what I see,
> that would be quite hard/impossible. So at the end, I think that we have
> to end-up with 2 solutions:
> 1) virtio_net, netvsc in-driver bonding - very limited, stupid, 0config
>    solution that works for all (no matter what OS you use in VM)
> 2) team/bond solution with assistance of preferably userspace daemon
>    getting info from baremetal. This is not 0config, but minimal config
>    - user just have to define this "magic bonding" should be on.
>    This covers all possible usecases, including multiple VFs, RDMA, etc.
> 
> Thoughts?

I think I agree. This RFC is trying to do 1 above.  Looks like we now
all agree 1 and 2 are not exclusive, both have place in the kernel. Is
that right?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

