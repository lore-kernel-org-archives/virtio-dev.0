Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
References: <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481DB5D0F4F3EAAEB26B047DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481C5C0EB93191416E36D4EDCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211014182437-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54806B9EEECE8920F450F86BDCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <047032b5-6b39-98cb-8517-2b02e5fb1560@redhat.com>
 <PH0PR12MB5481E5C62AD72F75792FC9B6DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs7gAipdbkj4DrpWLsxViHK_qicFVjy6Dy4qP7argih4g@mail.gmail.com>
 <PH0PR12MB548105873DCFFDE8FD95D0A6DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEthjkX3pV+1L9Eg-nJOArSUfmDRY8UCK_2LJ7-oxO6SpQ@mail.gmail.com>
 <DM8PR12MB548048016A0311F809BF0E67DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <CACGkMEuP6nZCSyz8piHYdMzwSKGgZbn65SBx486C-Lm2jbw5TA@mail.gmail.com>
 <PH0PR12MB5481C32F9D9A54AFA4E337A3DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2984c445-a7fd-97c4-34aa-3a40778a0fcd@redhat.com>
Date: Mon, 25 Oct 2021 13:41:36 +0800
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C32F9D9A54AFA4E337A3DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/10/22 下午3:20, Parav Pandit 写道:
>
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Friday, October 15, 2021 2:12 PM
>>
>> On Fri, Oct 15, 2021 at 4:21 PM Parav Pandit <parav@nvidia.com> wrote:
>>>
>>>> From: Jason Wang <jasowang@redhat.com>
>>>> Sent: Friday, October 15, 2021 12:33 PM
>>>>> Do you have pointer to it? I do not understand transport level reset.
>>>> https://lore.kernel.org/virtualization/7ebb9ba0-69a0-2279-9b9e-
>>>> 60c50db06e94@redhat.com/
>>>>
>>> I read it. PCI level reset to recover a faulty device is useful.
>>> But we are not talking about resetting a PCI level here.
>>>
>>> It is very straight forward. A virtio level is reseting the device and infinitely
>> waiting for it to come up.
>>> Instead of doing so, device is providing hint to let it wait for the time driver
>> should.
>>
>> See the question below. But what I want to say is something like:
>>
>> 1) transport driver may have a transport specific timeout
> Yes. virtio PCI transport has transport specific timeout provided by the PCI device in this proposal.
>
>> 2) if the transport driver meet that timeout during virtio reset, perform the
>> transport specific reset
>>
> This is the implementation choice when a device specified timeout expires, what to do.
> Should system abort initializing the device further?
> Should qemu user do ctrl+c?
> Should it retry device init at virtio level?
> Should it call transport (in this case PCI FLR) to reset the device?
> This depends on where virtio device is used.
> This proposal doesn't define what a system should do when reset timer expires. It out of scope and implementation choice based on the env.


So what I meant is, if PCI gives us an upper limit of the reset (e.g 
100ms as you said), can virtio device perform reset more than that? If 
not, can we simply use 100ms for virtio-pci or can we gain from having a 
smaller per device timeout? If yes, it looks like a violation for PCI.

It looks to there're many choices

1) driver reset timeout via module parameter or sysfs
2) transport driver reset timeout (e.g via virtio-pci)
3) device reset timeout

If we can solve the issue in 1) and 2), there's no need for 3) consider 
3) requires a changes is various places and may bring extra troubles.


>
>> It looks to me it will guarantee the success of the reset?
> You are describing the timeout expiration handling.


This looks more important than just having a device hint of the timeout. 
We don't want to block thing like module unload or device removal etc.


> Yes, an implementation can choose to perform transport level reset when timeout expires.
>
>>>>> If you are asking can PCI reset can be used to reset the device? Yes.
>>>> Yes, I meant PCI reset.
>>>>
>>>>> But here what we are talking about is, when virtio layer issue the
>>>>> device
>>>> reset, how long should it wait for that reset to complete.
>>>>
>>>> A question is that what do we expect the driver to do if there's a
>>>> timeout on the device reset?
>>> Oh ok. I understand your question now.
>>>
>>> As described in this proposal, when timeout expires during
>>> initialization probe time, this device cannot be operated by the virtio layer,
>> So it simply aborts further initialization sequence of the spec in section 3.1.1
>> after step_1.
>>> Device probe has failed. So HV has several options to act on it.
>>> For example, do device specific debug, or do transport specific reset, recreate
>> the device.
>>
>> But how about the device removal?
>>
>>>>> Typical example is virtio driver loading on physical virtio device
>>>>> agnostic of
>>>> the transport and waiting for the device to come out of reset.
>>>>
>>>> I'm not sure how hard we can meet a device/transport agnostic timeout.
>>>> E.g how can we know the timeout satisfy for the requirement of all
>>>> the transport?
>>>>
>>>>>>> If src is hw and dst is sw, sw will likely have similar
>>>>>>> capabilities as hw, not just
>>>>>> this particular one but many other. Isn't it?
>>>>>>
>>>>>> The problem is the when src is software backend without this
>> capability.
>>>>> It isn’t any different than any other RW field of the device.
>>>>> For example sw did virtio pci device emulation with 30 msix
>>>>> vectors and hw
>>>> has only 2.
>>>>
>>>> In the case of MSI-X, the migration can't be done directly from src
>>>> to dest. The only choice is some kind of software mediation.
>>>>
>>>> In the case of timeout, the mediation won't even help, since we
>>>> don't even present the timeout to guest. Even if the hypervisor can
>>>> see the timeout interface.
>>> Since sw didn’t presented the timeout to the guest, it will find a HW device
>> with similar capability (without timeout).
>>> Or may be it can find a device that already passed the device reset state and
>> attach such device.
>>> HV has its options.
>>>
>>> Still not any different than rest of the RW capabilities/registers.
>> So the timeout doesn't work if we can enforce that.
> Didn’t follow your comment. Enforce what?


I meant the timeout value doesn't work here since guest can't see that.


>
>> Seems sub optimal than doing a transport reset if possible.
> Transport level reset is not helpful for two main reasons.
> 1. A device under reset has nothing wrong at the PCI level.
> Device is just still under boot/resetting to service virtio level commands.
> So doing PCI level reset is actually adversely affect it further because PCI level reset will trigger more layers of unwanted reset.


Well, looking at the driver codes, there're various places that the 
reset() is not expected to be fail. My understanding is that your 
proposal only solve the issue when the reset can fail but not other. 
That's why we need seek help for transport layer support.


>
> 2. PCI level reset must complete in 100msec.


Did you mean 100ms is too long? If yes, please explain why.


>
> I still don't understand mixing transport level reset with virtio level reset in context of LM.
>
> If I read your original concern, that a sw device was exposed on HV-1 without device reset timeout.
> And now user wants to migrate this VM to HV-2 which has a hw device with device reset timeout.
> And now this device cannot be passed to the HV-2 because older sw device was attached to the VM.
> I am frankly not sure, if this is really a case to consider.


Actually, it's a choice of the cloud vendors. But consider there are 
very huge number of instances which is based on software virtio, it's a 
valid use case. But what I want to say is that, if we touch the spec, it 
will requires changes in the management layer as well. E.g if we can not 
migrate from hardware that support reset timeout to software that 
doesn't support reset timeout. It will be better if we can do that only 
in the driver.


> It still similar to any other migration case where two devices have different capabilities.
> For example, SW device supported 16 RSS queues. HW has 4 RSS queues....
> So now emulate that as well? :)


Similar but one more burden for the management if a simple 100ms timeout 
can work for virtio-pci.


> In another MSI-X example you provided emulated MSIX alterative was proposed. This is again not mapping the full hw device.
>
> So it is still sw device on other hand. User might as well just continue in sw mode.
>
> Let's assume for a moment that, this (rare) case should be considered.
>
> Once way to overcome this is below.
> (a) Do not place new device_reset_timeout field in struct virtio_pci_common_cfg.
> This is because this map be in memory mapped BAR directly accessible to the guest and future version of the spec has more fields after device reset timeout.
> Such fields are somehow implemented by the sw device on HV-1.
>
> (b) Instead, define new cfg_type VIRTIO_PCI_CAP_DEV_TIMEOUT_CFG.
> This points to the struct containing device reset timeout.
> Exposing this capability can be skipped when mapping the hw virtio device to VM on HV-2 to match sw virtio device of HV-1.


This will ease the hypervisor but anyhow hypervisor can choose to not 
expose the capability directly to guest (which will soon became a burden 
to support cross vendor live migration).

Thanks


