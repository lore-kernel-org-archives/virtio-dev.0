Return-Path: virtio-dev-return-3268-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B4CA3581806D
	for <virtio-dev@lists.oasis-open.org>; Fri, 23 Feb 2018 16:17:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223223802.GA2010@nanopsycho>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180216183817.42b07af6@cakuba.netronome.com> <CAKgT0UfU9gV2Y7hWFQi0vJoD9kYeoq+7cXmwAjXeV5zxXHa3dQ@mail.gmail.com>
 <CADGSJ217HahFJsGmNXMD6SwWiK374+u_YET8QqdsmofCRFZr=Q@mail.gmail.com>
 <CAKgT0Uda7Bmzf06RMmD7hCVLr8hHQxaY8Fk7w9Qy=7Vi6NODwQ@mail.gmail.com>
 <CADGSJ23WFYEYo2DpSPVfZsOLjoSpgWWVCtEZi84wrUHN-noxag@mail.gmail.com>
 <0d158bf6-79b3-442b-2c61-3e900ff40922@intel.com> <CADGSJ22Z1ujZOc+OS5E=MwGCy1nTn9D6mHKBz+J=K9+--8R+jg@mail.gmail.com>
 <20180223223802.GA2010@nanopsycho>
From: Siwei Liu <loseweigh@gmail.com>
Date: Fri, 23 Feb 2018 16:17:46 -0800
Message-ID: <CADGSJ23crXa024hpbHxatXKfpn=HDwz5ZDTenhYCDGo=60KZ0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, Jakub Kicinski <kubakici@wp.pl>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 23, 2018 at 2:38 PM, Jiri Pirko <jiri@resnulli.us> wrote:
> Fri, Feb 23, 2018 at 11:22:36PM CET, loseweigh@gmail.com wrote:
>
> [...]
>
>>>>
>>>> No, that's not what I was talking about of course. I thought you
>>>> mentioned the upgrade scenario this patch would like to address is to
>>>> use the bypass interface "to take the place of the original virtio,
>>>> and get udev to rename the bypass to what the original virtio_net
>>>> was". That is one of the possible upgrade paths for sure. However the
>>>> upgrade path I was seeking is to use the bypass interface to take the
>>>> place of original VF interface while retaining the name and network
>>>> configs, which generally can be done simply with kernel upgrade. It
>>>> would become limiting as this patch makes the bypass interface share
>>>> the same virtio pci device with virito backup. Can this bypass
>>>> interface be made general to take place of any pci device other than
>>>> virtio-net? This will be more helpful as the cloud users who has
>>>> existing setup on VF interface don't have to recreate it on virtio-net
>>>> and VF separately again.
>
> How that could work? If you have the VF netdev with all configuration
> including IPs and routes and whatever - now you want to do migration
> so you add virtio_net and do some weird in-driver bonding with it. But
> then, VF disappears and the VF netdev with that and also all
> configuration it had.
> I don't think this scenario is valid.

We are talking about making udev aware of the new virtio-bypass to
rebind the name of the old VF interface with supposedly virtio-bypass
*post the kernel upgrade*. Of course, this needs virtio-net backend to
supply the [bdf] info where the VF/PT device was located.

-Siwei


>
>
>>>
>>>
>>> Yes. This sounds interesting. Looks like you want an existing VM image with
>>> VF only configuration to get transparent live migration support by adding
>>> virtio_net with BACKUP feature.  We may need another feature bit to switch
>>> between these 2 options.
>>
>>Yes, that's what I was thinking about. I have been building something
>>like this before, and would like to get back after merging with your
>>patch.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

