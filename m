Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
References: <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
 <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
 <20210816013138-mutt-send-email-mst@kernel.org>
 <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org>
 <af73ed7b-b339-3ba2-87cb-176a9435fa2c@redhat.com>
 <20210817034312-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a3c6c452-b8be-0e78-0383-f6ff4a81f698@redhat.com>
Date: Tue, 17 Aug 2021 16:15:44 +0800
MIME-Version: 1.0
In-Reply-To: <20210817034312-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/8/17 下午3:51, Michael S. Tsirkin 写道:
> On Tue, Aug 17, 2021 at 01:45:12PM +0800, Jason Wang wrote:
>> 在 2021/8/16 下午7:48, Michael S. Tsirkin 写道:
>>> On Mon, Aug 16, 2021 at 12:05:50PM +0530, Srivatsa Vaddagiri wrote:
>>>> * Michael S. Tsirkin <mst@redhat.com> [2021-08-16 01:35:46]:
>>>>
>>>>> So thinking about all this, quite early in the setup process we
>>>>> have:
>>>>>
>>>>>           /* Figure out what features the device supports. */
>>>>>           device_features = dev->config->get_features(dev);
>>>>>
>>>>>
>>>>> isn't this sufficient? this will flush out
>>>>> all writes and device can defer responding to reads
>>>>> until reset is complete.
>>>> Hmm not sure if that's possible in all MMIO devices? I think a while back Jason
>>>> felt some of the MMIO devices, their registers could act as plain DRAM for
>>>> reads, which means device can't block such reads?
>>>>
>>>> - vatsa
>>> Is it worth bothering about theoretical issues though? Jason what is
>>> your take?
>>
>> Re-read the spec, and it said
>>
>> "
>>
>> MMIO Device Register Layout
>>
>> "
>>
>> I believe plain DRAM will not behave like a register. So we don't need to
>> worry about that.
>>
>> But they are indeed devices that act as a plain DRAM for their control path,
>> which might requires new transports[1].
>>
>> Another question is that what makes PCI differ from MMIO. (E.g PCI requires
>> a re-read but MMIO doesn't)
> I don't think PCI requires a re-read either.  IIRC from that meeting, it
> was intended for a hypervisor so it does not have to block the guest:
> the guest can do something else then re-read.
> We did similar things elsewhere.


Yes, but it has implication for the device implication.


>
> See
> https://issues.oasis-open.org/projects/VIRTIO/issues/VIRTIO-103
> for the original proposal.
>
> In any case, I would say status register is unlikely to be in regular
> DRAM, after all write has side effects.
> So before we move on I'd like to know whether we do something as drastic
> as incrementing the version number for a theoretical or practical
> benefit.


I agree.

Thanks


>
>
>> [1] https://lkml.org/lkml/2020/9/1/255
>>
>>
>>>
>>>> ---
>>>>
>>>> Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
>>>> non-member to the virtio-dev mailing list for consideration and inclusion.

