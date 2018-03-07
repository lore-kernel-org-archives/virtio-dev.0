Return-Path: virtio-dev-return-3464-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 22CE55818F22
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Mar 2018 10:56:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180307100630.0f7ba1df@xeon-e3>
References: <20180304185034.GE2112@nanopsycho.orion> <CAKgT0UdWYf0US7L-g3yGwU3KgYiobi0KfU835bR4TN8K++Tw4w@mail.gmail.com>
 <20180305092118.GG2112@nanopsycho.orion> <20180305081132.72b5159f@xeon-e3>
 <20180305223013.GA2144@nanopsycho> <CAKgT0UeUsQ13YYMhnE1i0aeWBVEKk34CujP1o68sapt-OiLUDg@mail.gmail.com>
 <20180305191508.298bd595@xeon-e3> <CAKgT0UckX6YhkVwCOGV5Jv5YRGXFAGj4goDRQQBwe9bM5tVpNQ@mail.gmail.com>
 <20180306225927.GB2144@nanopsycho> <CAKgT0Uf_c_yNJNHBbPs8MBybxmTJJx4u0mg8MrZd+=ZGot22XA@mail.gmail.com>
 <20180307043534-mutt-send-email-mst@kernel.org> <CAKgT0UfpH-XBa4yrTVWna_3ftrmj-S0p4Qoin3hgH=xLEfgHDQ@mail.gmail.com>
 <20180307100630.0f7ba1df@xeon-e3>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 7 Mar 2018 10:55:58 -0800
Message-ID: <CAKgT0Ue+f8JFmCfE8N-nx5xUoa9YJezDjEo6MOifSZ-2ZJKQxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when available
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 7, 2018 at 10:06 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Wed, 7 Mar 2018 09:50:50 -0800
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
>> On Tue, Mar 6, 2018 at 6:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Tue, Mar 06, 2018 at 03:27:46PM -0800, Alexander Duyck wrote:
>> >> > I definitelly vote for a separate common shared code for both netvsc and
>> >> > virtio_net - even if you use 2 and 3 netdev model, you could share the
>> >> > common code. Strict checks and limitation should be in place.
>> >>
>> >> Noted. But as I also mentioned there isn't that much "common" code
>> >> between the two models. I think if anything we could probably look at
>> >> peeling out a few bits such as "get_<iface>_bymac" which really would
>> >> become dev_get_by_mac_and_ops in order to find the device for the
>> >> notifiers. I probably wouldn't even put that in our driver and would
>> >> instead put it in the core code since it almost makes more sense
>> >> there. Beyond that sharing becomes much more challenging due to the
>> >> differences in the Rx and Tx paths that build out of the difference
>> >> between the 2 driver and 3 driver models.
>> >
>> > At this point it might be worth it to articulate the advantages
>> > of the 3 netdev model.
>>
>> The main advantages are performance on the lower devices. Specifically
>> we can run LLTX and IFF_NOQUEUE on the upper device, meaning the VF
>> doesn't take a performance hit when we start transmitting through it.
>> In addition the paravirtual device is able to fully expose it's
>> features, so for example virtio_net can maintain in-driver XDP, and we
>> can provide generic XDP on the upper device. We can also have an
>> asymmetric configuration where the number of queues or feature sets
>> can be different between the ports.
>>
>> Basically what it comes down to is in the 3 netdev model we never have
>> to deal with the issues of going from being a standard netdev to being
>> a master netdev. The role of each netdev is clearly defined.
>>
>> As far as doing a generic solution it is the preferred way to go as
>> well since we don't have to rewrite functionality of the lower device.
>> Currently the only changes really needed are to add a phys_port_name
>> operation so that you can distinguish between the bypass interface and
>> the original paravirtual one. As such you have no confusion about what
>> you are running.
>>
>> > If they are compelling, why wouldn't netvsc users want them?
>>
>> I believe part of the logic for Stephen's choice is that netvsc
>> doesn't have a "BACKUP" bit like what we have virtio_net. As a result
>> they have no way of knowing if a VF will ever show up or not. That
>> makes the 3 netdev solution less appealing as they always end up in
>> the bonding mode. In addition they have intentionally limited
>> themselves to avoid features such as XDP that would cause issues with
>> the 2 netdev model.
>>
>> > Alex, I think you were one of the strongest proponents of this model,
>> > you should be well placed to provide a summary.
>>
>> Hopefully the information provided helps. In my mind the issue is that
>> netvsc was not designed correctly, and as such it is using the 2
>> netdev model as a bit of a crutch to handle the case where they wanted
>> to add a VF bypass. At this point it has become a part of their
>> architecture so it would be confusing for their user base to deal with
>> having 2 netdevs spawn every time their driver sees a new device. In
>> the case of virtio we only spawn 2 netdevs if the backup bit is set
>> which implies a specific use case. When the bit isn't set we are only
>> spawning one device, and as a result we can get much better
>> performance out of the resultant combination of devices, and can
>> expose functionality such as in-driver XDP in virtio.
>
>
> I have experimented with toggling IFF_NOQUEUE and/or LLTX on the netvsc
> device when doing passthrough. It didn't help performance much and there
> are corner cases that make it painful, like what if qdisc was placed
> by user on the netvsc device?  Should the qdisc then be moved back
> and forth to the VF device when it arrives or is removed?

The advantages of IFF_NOQUEUE and LLTX would mostly be seen on small
packets, and I wouldn't risk toggling them on/off as doing so with
packets in flight might lead to odd results. That was one of the
reasons why I wanted to just stick with the 3 netdev model for us, and
leave you guys running with the 2 netdev model.

> As far as XDP support, it is on the plan to support XDP on the netvsc
> device since the receive buffers do have to be copied. But there has
> been no customer demand for it; and the VF model on Azure has limitations
> which make a transparent XDP model pretty much impossible.

I wasn't saying you needed to implement XDP in netvsc. My point was
that in virtio we already have it and it would be confusing for us to
have a virtio driver that had to drop support for it in order to
support the 2 netdev model.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

