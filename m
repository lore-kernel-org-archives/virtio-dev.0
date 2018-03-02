Return-Path: virtio-dev-return-3380-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 26A955818F64
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 11:43:00 -0800 (PST)
Date: Fri, 2 Mar 2018 21:42:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302214114-mutt-send-email-mst@kernel.org>
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <20180302083605.GD2099@nanopsycho>
 <CAKgT0UeMQ8GkHLrCHQ_OfFw3beqHVM2QvbRt7zoZKf1Vwvbt1A@mail.gmail.com>
 <20180302162017.GG2099@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302162017.GG2099@nanopsycho>
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when
 available
To: Jiri Pirko <jiri@resnulli.us>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 02, 2018 at 05:20:17PM +0100, Jiri Pirko wrote:
> >Yeah, this code essentially calls out the "shareable" code with a
> >comment at the start and end of the section what defines the
> >virtio_bypass functionality. It would just be a matter of mostly
> >cutting and pasting to put it into a separate driver module.
> 
> Please put it there and unite the use of it with netvsc.

Surely, adding this to other drivers (e.g. might this be handy for xen
too?) can be left for a separate patchset. Let's get one device merged
first.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

