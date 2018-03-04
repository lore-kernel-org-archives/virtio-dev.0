Return-Path: virtio-dev-return-3408-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D7CE5818F23
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Mar 2018 10:24:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180304071329.GA2112@nanopsycho.orion>
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <20180302083605.GD2099@nanopsycho> <CAKgT0UeMQ8GkHLrCHQ_OfFw3beqHVM2QvbRt7zoZKf1Vwvbt1A@mail.gmail.com>
 <20180302162017.GG2099@nanopsycho> <20180302214114-mutt-send-email-mst@kernel.org>
 <20180303113120.GA3205@nanopsycho.orion> <CAKgT0UcdJ0D-64N0cKsZtpqyKWsXkoPTdvRPxoCrpU=q1T8UuA@mail.gmail.com>
 <20180303212542.GA10132@nanopsycho.orion> <CAKgT0UeH3JGGEvwwFfjpde=iPwV7s2MEwhKk08ixedCXZHcCFg@mail.gmail.com>
 <20180304071329.GA2112@nanopsycho.orion>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 4 Mar 2018 10:24:12 -0800
Message-ID: <CAKgT0UfHg6OfLzYGSo2vM9PCqpajHW-RAEJ0WQbx6NT8H_AQDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Mar 3, 2018 at 11:13 PM, Jiri Pirko <jiri@resnulli.us> wrote:
> Sun, Mar 04, 2018 at 01:26:53AM CET, alexander.duyck@gmail.com wrote:
>>On Sat, Mar 3, 2018 at 1:25 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Sat, Mar 03, 2018 at 07:04:57PM CET, alexander.duyck@gmail.com wrote:
>>>>On Sat, Mar 3, 2018 at 3:31 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>> Fri, Mar 02, 2018 at 08:42:47PM CET, mst@redhat.com wrote:
>>>>>>On Fri, Mar 02, 2018 at 05:20:17PM +0100, Jiri Pirko wrote:
>>>>>>> >Yeah, this code essentially calls out the "shareable" code with a
>>>>>>> >comment at the start and end of the section what defines the
>>>>>>> >virtio_bypass functionality. It would just be a matter of mostly
>>>>>>> >cutting and pasting to put it into a separate driver module.
>>>>>>>
>>>>>>> Please put it there and unite the use of it with netvsc.
>>>>>>
>>>>>>Surely, adding this to other drivers (e.g. might this be handy for xen
>>>>>>too?) can be left for a separate patchset. Let's get one device merged
>>>>>>first.
>>>>>
>>>>> Why? Let's do the generic infra alongside with the driver. I see no good
>>>>> reason to rush into merging driver and only later, if ever, to convert
>>>>> it to generic solution. On contrary. That would lead into multiple
>>>>> approaches and different behavious in multiple drivers. That is plain
>>>>> wrong.
>>>>
>>>>If nothing else it doesn't hurt to do this in one driver in a generic
>>>>way, and once it has been proven to address all the needs of that one
>>>>driver we can then start moving other drivers to it. The current
>>>>solution is quite generic, that was my contribution to this patch set
>>>>as I didn't like how invasive it was being to virtio and thought it
>>>>would be best to keep this as minimally invasive as possible.
>>>>
>>>>My preference would be to give this a release or two in virtio to
>>>>mature before we start pushing it onto other drivers. It shouldn't
>>>>take much to cut/paste this into a new driver file once we decide it
>>>>is time to start extending it out to other drivers.
>>>
>>> I'm not talking about cut/paste and in fact that is what I'm worried
>>> about. I'm talking about common code in net/core/ or somewhere that
>>> would take care of this in-driver bonding. Each driver, like virtio_net,
>>> netvsc would just register some ops to it and the core would do all
>>> logic. I believe it is essential take this approach from the start.
>>
>>Sorry, I didn't mean cut/paste into another driver, I meant to make it
>>a driver of its own. My thought was to eventually create a shared/core
>>driver module that is then used by the other drivers.
>>
>>My concern right now is that Stephen has indicated he doesn't want
>>this approach taken with netvsc, and most of the community doesn't
>
> IIUC, he only does not like the extra netdev. Is there anything else?

Nope that is pretty much it. It doesn't seem like a big deal for
virtio, but for netvsc it is significant since they don't have any
"backup" bit feature differentiation, so they would likely be stuck
with 2 netdevs even in their basic setup.

>>want the netvsc approach applied to virtio. Until that impasse can be
>>resolved there isn't much value in trying to split this up so it is
>>available to other drivers. In addition I would imagine it would make
>>it a pain for others to back-port into distros since it would break
>>legacy netvsc driver behavior. Patches are always welcome. Once this
>>is in you are free to try fighting to get this made into a generic
>>module and applied to both drivers, but we have already spent close to
>>3 months on this and it seems like there has been significantly more
>
> Alex, time is never a good argument for poor design and shortcuts.

I'm not saying we should go with a poor design due to time. But
expecting us to implement something where the maintainer of said
driver has not agreed to is pointless, and I don't see it as a design
shortcut to implement something in one driver with the expectation
that we will then make it core later once it has proven itself and has
use elsewhere. In the meantime I would imagine it also makes it easier
for things like backports and such for us to do it this way since we
are only impacting one driver.

You are telling us to do something that not everyone has agreed to.
Currently we only have agreement from Michael on taking this code, as
such we are working with virtio only for now. When the time comes that
we can get other maintainers, specifically Stephen, to agree to it
then we can cut/paste this code into a core file or into a module of
its own. Alternatively I suppose we could take this up to Dave if you
can't get Stephen to agree. If you can get Dave to say we need to
change netvsc then we will go ahead with it, but generally I prefer to
respect when the maintainer of something says they don't want us
modifying their code in some way.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

