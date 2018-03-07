Return-Path: virtio-dev-return-3443-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 63DC35818038
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Mar 2018 18:39:07 -0800 (PST)
Date: Wed, 7 Mar 2018 04:38:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180307043534-mutt-send-email-mst@kernel.org>
References: <20180304185034.GE2112@nanopsycho.orion>
 <CAKgT0UdWYf0US7L-g3yGwU3KgYiobi0KfU835bR4TN8K++Tw4w@mail.gmail.com>
 <20180305092118.GG2112@nanopsycho.orion>
 <20180305081132.72b5159f@xeon-e3>
 <20180305223013.GA2144@nanopsycho>
 <CAKgT0UeUsQ13YYMhnE1i0aeWBVEKk34CujP1o68sapt-OiLUDg@mail.gmail.com>
 <20180305191508.298bd595@xeon-e3>
 <CAKgT0UckX6YhkVwCOGV5Jv5YRGXFAGj4goDRQQBwe9bM5tVpNQ@mail.gmail.com>
 <20180306225927.GB2144@nanopsycho>
 <CAKgT0Uf_c_yNJNHBbPs8MBybxmTJJx4u0mg8MrZd+=ZGot22XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uf_c_yNJNHBbPs8MBybxmTJJx4u0mg8MrZd+=ZGot22XA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when
 available
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 06, 2018 at 03:27:46PM -0800, Alexander Duyck wrote:
> > I definitelly vote for a separate common shared code for both netvsc and
> > virtio_net - even if you use 2 and 3 netdev model, you could share the
> > common code. Strict checks and limitation should be in place.
> 
> Noted. But as I also mentioned there isn't that much "common" code
> between the two models. I think if anything we could probably look at
> peeling out a few bits such as "get_<iface>_bymac" which really would
> become dev_get_by_mac_and_ops in order to find the device for the
> notifiers. I probably wouldn't even put that in our driver and would
> instead put it in the core code since it almost makes more sense
> there. Beyond that sharing becomes much more challenging due to the
> differences in the Rx and Tx paths that build out of the difference
> between the 2 driver and 3 driver models.

At this point it might be worth it to articulate the advantages
of the 3 netdev model.

If they are compelling, why wouldn't netvsc users want them?

Alex, I think you were one of the strongest proponents of this model,
you should be well placed to provide a summary.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

