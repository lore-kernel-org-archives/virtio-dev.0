Return-Path: virtio-dev-return-3441-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 859ED5818F9A
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Mar 2018 15:27:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306225927.GB2144@nanopsycho>
References: <20180304071329.GA2112@nanopsycho.orion> <CAKgT0UfHg6OfLzYGSo2vM9PCqpajHW-RAEJ0WQbx6NT8H_AQDg@mail.gmail.com>
 <20180304185034.GE2112@nanopsycho.orion> <CAKgT0UdWYf0US7L-g3yGwU3KgYiobi0KfU835bR4TN8K++Tw4w@mail.gmail.com>
 <20180305092118.GG2112@nanopsycho.orion> <20180305081132.72b5159f@xeon-e3>
 <20180305223013.GA2144@nanopsycho> <CAKgT0UeUsQ13YYMhnE1i0aeWBVEKk34CujP1o68sapt-OiLUDg@mail.gmail.com>
 <20180305191508.298bd595@xeon-e3> <CAKgT0UckX6YhkVwCOGV5Jv5YRGXFAGj4goDRQQBwe9bM5tVpNQ@mail.gmail.com>
 <20180306225927.GB2144@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Mar 2018 15:27:46 -0800
Message-ID: <CAKgT0Uf_c_yNJNHBbPs8MBybxmTJJx4u0mg8MrZd+=ZGot22XA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: Stephen Hemminger <stephen@networkplumber.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 6, 2018 at 2:59 PM, Jiri Pirko <jiri@resnulli.us> wrote:
> Tue, Mar 06, 2018 at 08:08:21PM CET, alexander.duyck@gmail.com wrote:
>>On Mon, Mar 5, 2018 at 7:15 PM, Stephen Hemminger
>><stephen@networkplumber.org> wrote:
>>> On Mon, 5 Mar 2018 14:47:20 -0800
>>> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>>>
>>>> On Mon, Mar 5, 2018 at 2:30 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>> > Mon, Mar 05, 2018 at 05:11:32PM CET, stephen@networkplumber.org wrote:
>>>> >>On Mon, 5 Mar 2018 10:21:18 +0100
>>>> >>Jiri Pirko <jiri@resnulli.us> wrote:
>>>> >>
>>>> >>> Sun, Mar 04, 2018 at 10:58:34PM CET, alexander.duyck@gmail.com wrote:
>>>> >>> >On Sun, Mar 4, 2018 at 10:50 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>> >>> >> Sun, Mar 04, 2018 at 07:24:12PM CET, alexander.duyck@gmail.com wrote:
>>>> >>> >>>On Sat, Mar 3, 2018 at 11:13 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>> >>>
>>>> >>> [...]
>>>> >>>
>>>> >>> >
>>>> >>> >>>Currently we only have agreement from Michael on taking this code, as
>>>> >>> >>>such we are working with virtio only for now. When the time comes that
>>>> >>> >>
>>>> >>> >> If you do duplication of netvsc in-driver bonding in virtio_net, it will
>>>> >>> >> stay there forever. So what you say is: "We will do it halfway now
>>>> >>> >> and promise to fix it later". That later will never happen, I'm pretty
>>>> >>> >> sure. That is why I push for in-driver bonding shared code as a part of
>>>> >>> >> this patchset.
>>>> >>> >
>>>> >>> >You want this new approach and a copy of netvsc moved into either core
>>>> >>> >or some module of its own. I say pick an architecture. We are looking
>>>> >>> >at either 2 netdevs or 3. We are not going to support both because
>>>> >>> >that will ultimately lead to a terrible user experience and make
>>>> >>> >things quite confusing.
>>>> >>> >
>>>> >>> >> + if you would be pushing first driver to do this, I would understand.
>>>> >>> >> But the first driver is already in. You are pushing second. This is the
>>>> >>> >> time to do the sharing, unification of behaviour. Next time is too late.
>>>> >>> >
>>>> >>> >That is great, if we want to share then lets share. But what you are
>>>> >>> >essentially telling us is that we need to fork this solution and
>>>> >>> >maintain two code paths, one for 2 netdevs, and another for 3. At that
>>>> >>> >point what is the point in merging them together?
>>>> >>>
>>>> >>> Of course, I vote for the same behaviour for netvsc and virtio_net. That
>>>> >>> is my point from the very beginning.
>>>> >>>
>>>> >>> Stephen, what do you think? Could we please make virtio_net and netvsc
>>>> >>> behave the same and to use a single code with well-defined checks and
>>>> >>> restrictions for this feature?
>>>> >>
>>>> >>Eventually, yes both could share common code routines. In reality,
>>>> >>the failover stuff is only a very small part of either driver so
>>>> >>it is not worth stretching to try and cover too much. If you look,
>>>> >>the failover code is just using routines that already exist for
>>>> >>use by bonding, teaming, etc.
>>>> >
>>>> > Yeah, we consern was also about the code that processes the netdev
>>>> > notifications and does auto-enslave and all related stuff.
>>>>
>>>> The concern was the driver model. If we expose 3 netdevs or 2 with the
>>>> VF driver present. Somehow this is turning into a "merge netvsc into
>>>> virtio" think and that isn't the subject that was being asked.
>>>>
>>>> Ideally we want one model for this. Either 3 netdevs or 2. The problem
>>>> is 2 causes issues in terms of performance and will limit features of
>>>> virtio, but 2 is the precedent set by netvsc. We need to figure out
>>>> the path forward for this. There is talk about "sharing" but it is
>>>> hard to make these two approaches share code when they are doing two
>>>> very different setups and end up presenting themselves as two very
>>>> different driver models.
>>>
>>> I appreciate this discussion, and it has helped a lot.
>>>
>>> Netvsc is stuck with 2 netdev model for the foreseeable future.
>>> We already failed once with the bonding model, and that created a lot of
>>> pain. The current model is working well and have convinced the major distros
>>> to support the two netdev model and don't want to back.
>>>
>>> Very open to optimizations and ways to smooth out the rough edges.
>>
>>Thank you for clarifying this Stephen.
>>
>>Okay. So with things defined such that we are doing a 2 netdev model
>>for netvsc, and a 3 netdev model for virtio, is it still in our
>>interest for us to try making a shared library between the two? In my
>>mind, the virtnet_bypass becomes the way we go forward for any future
>>solutions. I say we treat the netvsc approach as a "legacy" approach
>>and avoid creating any new libraries or drivers to support it, and
>>instead just focus on the 3 netdev approach as the way this is to be
>>done going forward. That way we avoid anyone else trying to implement
>>something like the 2 netdev solution in the future.
>>
>>So getting back to the code here. Should we split the virtnet_bypass
>>code out into a separate module? My preference would be to let this
>>incubate as a part of virtio_net until either there is another user,
>>or it becomes big enough that it needs to be moved. That said, there
>
> What do you mean by "big enough"? I hope that is will never be extended
> by anything. If you need to do anything more complex, you should use
> bong/team.

I wasn't thinking so much extra features as enough workaround for
discovered issues. Really this should be more-or-less feature locked.

> I definitelly vote for a separate common shared code for both netvsc and
> virtio_net - even if you use 2 and 3 netdev model, you could share the
> common code. Strict checks and limitation should be in place.

Noted. But as I also mentioned there isn't that much "common" code
between the two models. I think if anything we could probably look at
peeling out a few bits such as "get_<iface>_bymac" which really would
become dev_get_by_mac_and_ops in order to find the device for the
notifiers. I probably wouldn't even put that in our driver and would
instead put it in the core code since it almost makes more sense
there. Beyond that sharing becomes much more challenging due to the
differences in the Rx and Tx paths that build out of the difference
between the 2 driver and 3 driver models.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

