Return-Path: virtio-dev-return-3871-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BED21581916B
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Apr 2018 23:10:18 -0700 (PDT)
References: <54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com>
 <20180404.133749.1802514210170809419.davem@davemloft.net>
 <CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
 <20180408.123207.2294740686493951200.davem@davemloft.net>
 <CADGSJ233AmbBrTP-A_u3-5fkr=HUJka_xcSNWxO1HWGua1J92Q@mail.gmail.com>
 <CADGSJ21nQ1BQctfZcThpmOcOUrpqLfG71jsh2trb1utVjNQH=Q@mail.gmail.com>
 <1f3af59f-fd64-cc0d-f9eb-668636c52db4@intel.com>
 <20180419072003-mutt-send-email-mst@kernel.org>
 <4e029524-d542-0f12-bfdb-7c8a2f198e28@intel.com>
 <20180419080215-mutt-send-email-mst@kernel.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <5d5f1e52-bddf-5551-bdea-8e7b408b39b9@intel.com>
Date: Wed, 18 Apr 2018 23:10:05 -0700
MIME-Version: 1.0
In-Reply-To: <20180419080215-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN
 netdevice
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>, Jiri Pirko <jiri@resnulli.us>, si-wei liu <si-wei.liu@oracle.com>, Stephen Hemminger <stephen@networkplumber.org>, Alexander Duyck <alexander.h.duyck@intel.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 4/18/2018 10:07 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 18, 2018 at 10:00:51PM -0700, Samudrala, Sridhar wrote:
>> On 4/18/2018 9:41 PM, Michael S. Tsirkin wrote:
>>> On Wed, Apr 18, 2018 at 04:33:34PM -0700, Samudrala, Sridhar wrote:
>>>> On 4/17/2018 5:26 PM, Siwei Liu wrote:
>>>>> I ran this with a few folks offline and gathered some good feedbacks
>>>>> that I'd like to share thus revive the discussion.
>>>>>
>>>>> First of all, as illustrated in the reply below, cloud service
>>>>> providers require transparent live migration. Specifically, the main
>>>>> target of our case is to support SR-IOV live migration via kernel
>>>>> upgrade while keeping the userspace of old distros unmodified. If it's
>>>>> because this use case is not appealing enough for the mainline to
>>>>> adopt, I will shut up and not continue discussing, although
>>>>> technically it's entirely possible (and there's precedent in other
>>>>> implementation) to do so to benefit any cloud service providers.
>>>>>
>>>>> If it's just the implementation of hiding netdev itself needs to be
>>>>> improved, such as implementing it as attribute flag or adding linkdump
>>>>> API, that's completely fine and we can look into that. However, the
>>>>> specific issue needs to be undestood beforehand is to make transparent
>>>>> SR-IOV to be able to take over the name (so inherit all the configs)
>>>>> from the lower netdev, which needs some games with uevents and name
>>>>> space reservation. So far I don't think it's been well discussed.
>>>>>
>>>>> One thing in particular I'd like to point out is that the 3-netdev
>>>>> model currently missed to address the core problem of live migration:
>>>>> migration of hardware specific feature/state, for e.g. ethtool configs
>>>>> and hardware offloading states. Only general network state (IP
>>>>> address, gateway, for eg.) associated with the bypass interface can be
>>>>> migrated. As a follow-up work, bypass driver can/should be enhanced to
>>>>> save and apply those hardware specific configs before or after
>>>>> migration as needed. The transparent 1-netdev model being proposed as
>>>>> part of this patch series will be able to solve that problem naturally
>>>>> by making all hardware specific configurations go through the central
>>>>> bypass driver, such that hardware configurations can be replayed when
>>>>> new VF or passthrough gets plugged back in. Although that
>>>>> corresponding function hasn't been implemented today, I'd like to
>>>>> refresh everyone's mind that is the core problem any live migration
>>>>> proposal should have addressed.
>>>>>
>>>>> If it would make things more clear to defer netdev hiding until all
>>>>> functionalities regarding centralizing and replay are implemented,
>>>>> we'd take advices like that and move on to implementing those features
>>>>> as follow-up patches. Once all needed features get done, we'd resume
>>>>> the work for hiding lower netdev at that point. Think it would be the
>>>>> best to make everyone understand the big picture in advance before
>>>>> going too far.
>>>> I think we should get the 3-netdev model integrated and add any additional
>>>> ndo_ops/ethool ops that we would like to support/migrate before looking into
>>>> hiding the lower netdevs.
>>> Once they are exposed, I don't think we'll be able to hide them -
>>> they will be a kernel ABI.
>>>
>>> Do you think everyone needs to hide the SRIOV device?
>>> Or that only some users need this?
>> Hyper-V is currently supporting live migration without hiding the SR-IOV device. So i don't
>> think it is a hard requirement.
> OK, fine.
>
>> And also,  as we don't yet have a consensus on how to hide
>> the lower netdevs, we could make it as another feature bit to hide lower netdevs once
>> we have an acceptable solution.
> Guest/host interface isn't more flexible than the userspace/kernel
> interface.  The feature bit you propose would say what exactly?
> Hypervisor has no idea what guest kernel shows guest userspace.
> Note that the backup flag doesn't tell guest kernel what to do,
> it just tells guest that there is or will be a faster main device
> connected to the same backend, so the backup should only be used
> when main device is not present.

The current bypass module supports 3-netdev and 2-netdev models via 2 sets of interfaces
bypass_master_create/destroy and bypass_master_register/unregister.  So theoretically
we can support the 2 models via 2 different feature bits. BACKUP and BACKUP_2_NETDEV.

Similarly if we can figure out a way to hide both the netdevs, we can add BACKUP_1_NETDEV
feature bit and update the bypass module to provide another set of interfaces that can
be used by virtio_net to support this model.

Now that we are leaning towards 'standby' as the name for the lower virtio-net, should we
change the feature bit name also to VIRTIO_NET_F_STANDBY?

>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

