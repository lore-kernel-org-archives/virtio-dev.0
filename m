Return-Path: virtio-dev-return-3383-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 38EB65819034
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 12:10:44 -0800 (PST)
Date: Fri, 2 Mar 2018 22:10:33 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302220932-mutt-send-email-mst@kernel.org>
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <20180302083605.GD2099@nanopsycho>
 <CAKgT0UeMQ8GkHLrCHQ_OfFw3beqHVM2QvbRt7zoZKf1Vwvbt1A@mail.gmail.com>
 <20180302213920-mutt-send-email-mst@kernel.org>
 <04e6981c-bb8d-0af9-5fe3-b9a7f7def3f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e6981c-bb8d-0af9-5fe3-b9a7f7def3f5@intel.com>
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when
 available
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 02, 2018 at 11:52:27AM -0800, Samudrala, Sridhar wrote:
> 
> 
> On 3/2/2018 11:41 AM, Michael S. Tsirkin wrote:
> > On Fri, Mar 02, 2018 at 07:26:25AM -0800, Alexander Duyck wrote:
> > > The design limits things to a 1:1 relationship since we just have the
> > > child and backup pointers, but I don't think I am seeing exception
> > > handling to prevent us from overwriting the child pointers so there
> > > may be a leak there.
> > > 
> > > Thanks.
> > > 
> > > - Alex
> > In fact maintaining a list in that case would be nicer, and
> > just use an arbitrary one.
> > E.g. one can see how a user wanting to swap device 1 for device 2
> > might first add device 2 with same MAC then drop device 1.
> 
> It should be possible to swap VF1 with VF2 by
> 1.- enabling virtio link
> 2.- unplugging VF1
> 3.- plugging VF2
> 4.- disabling virtio link
> 

True, but it isn't hard to avoid breakage if user
swapped steps 2 and 3. No need to make it more
fragile that it has to be.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

