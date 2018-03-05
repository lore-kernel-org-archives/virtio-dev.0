Return-Path: virtio-dev-return-3423-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D3045818F74
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Mar 2018 14:47:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305223013.GA2144@nanopsycho>
References: <20180303113120.GA3205@nanopsycho.orion> <CAKgT0UcdJ0D-64N0cKsZtpqyKWsXkoPTdvRPxoCrpU=q1T8UuA@mail.gmail.com>
 <20180303212542.GA10132@nanopsycho.orion> <CAKgT0UeH3JGGEvwwFfjpde=iPwV7s2MEwhKk08ixedCXZHcCFg@mail.gmail.com>
 <20180304071329.GA2112@nanopsycho.orion> <CAKgT0UfHg6OfLzYGSo2vM9PCqpajHW-RAEJ0WQbx6NT8H_AQDg@mail.gmail.com>
 <20180304185034.GE2112@nanopsycho.orion> <CAKgT0UdWYf0US7L-g3yGwU3KgYiobi0KfU835bR4TN8K++Tw4w@mail.gmail.com>
 <20180305092118.GG2112@nanopsycho.orion> <20180305081132.72b5159f@xeon-e3> <20180305223013.GA2144@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 5 Mar 2018 14:47:20 -0800
Message-ID: <CAKgT0UeUsQ13YYMhnE1i0aeWBVEKk34CujP1o68sapt-OiLUDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: Stephen Hemminger <stephen@networkplumber.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 5, 2018 at 2:30 PM, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, Mar 05, 2018 at 05:11:32PM CET, stephen@networkplumber.org wrote:
>>On Mon, 5 Mar 2018 10:21:18 +0100
>>Jiri Pirko <jiri@resnulli.us> wrote:
>>
>>> Sun, Mar 04, 2018 at 10:58:34PM CET, alexander.duyck@gmail.com wrote:
>>> >On Sun, Mar 4, 2018 at 10:50 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> >> Sun, Mar 04, 2018 at 07:24:12PM CET, alexander.duyck@gmail.com wrote:
>>> >>>On Sat, Mar 3, 2018 at 11:13 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>
>>> [...]
>>>
>>> >
>>> >>>Currently we only have agreement from Michael on taking this code, as
>>> >>>such we are working with virtio only for now. When the time comes that
>>> >>
>>> >> If you do duplication of netvsc in-driver bonding in virtio_net, it will
>>> >> stay there forever. So what you say is: "We will do it halfway now
>>> >> and promise to fix it later". That later will never happen, I'm pretty
>>> >> sure. That is why I push for in-driver bonding shared code as a part of
>>> >> this patchset.
>>> >
>>> >You want this new approach and a copy of netvsc moved into either core
>>> >or some module of its own. I say pick an architecture. We are looking
>>> >at either 2 netdevs or 3. We are not going to support both because
>>> >that will ultimately lead to a terrible user experience and make
>>> >things quite confusing.
>>> >
>>> >> + if you would be pushing first driver to do this, I would understand.
>>> >> But the first driver is already in. You are pushing second. This is the
>>> >> time to do the sharing, unification of behaviour. Next time is too late.
>>> >
>>> >That is great, if we want to share then lets share. But what you are
>>> >essentially telling us is that we need to fork this solution and
>>> >maintain two code paths, one for 2 netdevs, and another for 3. At that
>>> >point what is the point in merging them together?
>>>
>>> Of course, I vote for the same behaviour for netvsc and virtio_net. That
>>> is my point from the very beginning.
>>>
>>> Stephen, what do you think? Could we please make virtio_net and netvsc
>>> behave the same and to use a single code with well-defined checks and
>>> restrictions for this feature?
>>
>>Eventually, yes both could share common code routines. In reality,
>>the failover stuff is only a very small part of either driver so
>>it is not worth stretching to try and cover too much. If you look,
>>the failover code is just using routines that already exist for
>>use by bonding, teaming, etc.
>
> Yeah, we consern was also about the code that processes the netdev
> notifications and does auto-enslave and all related stuff.

The concern was the driver model. If we expose 3 netdevs or 2 with the
VF driver present. Somehow this is turning into a "merge netvsc into
virtio" think and that isn't the subject that was being asked.

Ideally we want one model for this. Either 3 netdevs or 2. The problem
is 2 causes issues in terms of performance and will limit features of
virtio, but 2 is the precedent set by netvsc. We need to figure out
the path forward for this. There is talk about "sharing" but it is
hard to make these two approaches share code when they are doing two
very different setups and end up presenting themselves as two very
different driver models.

>>
>>There will always be two drivers, the ring buffers and buffering
>>are very different between vmbus and virtio. It would help to address
>>some of the awkward stuff like queue selection and offload handling
>>in a common way.
>
> Agreed.

There are going to end up being three drivers by the time we are done.
We will end up with netvsc, virtio, and some shared block of
functionality that is used between the two of them. At least that is
the assumption if the two are going to share code. I don't know if
everyone will want to take on the extra overhead for the code shared
between these two drivers being a part of the core net code.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

