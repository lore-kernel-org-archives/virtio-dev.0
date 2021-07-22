Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-mmio: Specify wait needed in driver
 during reset
References: <BY5PR02MB7073F1EAF729D30ACFFC67FCF9E49@BY5PR02MB7073.namprd02.prod.outlook.com>
 <b380151d-f20e-4e63-f1c3-a3f2220270cf@redhat.com> <87pmva7h06.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f2b9203c-faaf-9aba-faad-0df2c199cb94@redhat.com>
Date: Thu, 22 Jul 2021 20:53:32 +0800
MIME-Version: 1.0
In-Reply-To: <87pmva7h06.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/22 下午6:57, Cornelia Huck 写道:
> On Thu, Jul 22 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> 在 2021/7/22 下午5:19, Srivatsa Vaddagiri 写道:
>>> This is following up on the discussion we had earlier on MMIO reset
>>> behavior:
>>>
>>> https://lists.oasis-open.org/archives/virtio-dev/202107/msg00012.html
>>> <https://lists.oasis-open.org/archives/virtio-dev/202107/msg00012.html>
>>>
>>> Suggesting below change to spec to make it explicit what's expected in
>>> driver. If this is accepted, I will follow up with a patch to Linux
>>> driver.
>>>
>>> ===
>>>
>>> Device reset is accomplished by writing 0 to Status register.
>>> Explicitly note
>>> that a driver needs to wait on Status register read returning 0 before
>>> assuming that
>>> device reset operation is complete.
>>> Signed-off-by: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
>>
>>
>> I wonder if it deserves a feature bit.
> Not sure what that feature bit should govern; if it is not negotiated,
> the device must assume that the driver considers the reset to be
> complete right after writing? I'm not sure what the device is supposed
> to do then.


The (hardware) device can refuse the feature negotiation if driver 
doesn't support the feature.

This makes sure the driver is not broken by the device.

Thanks


>
>>
>> Thanks
>>
>>
>>> diff --git a/content.tex b/content.tex
>>> index 5c70a3c..7631be4 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -1985,6 +1985,10 @@ \subsubsection{Device
>>> Initialization}\label{sec:Virtio Transport Options / Virti
>>>   and if its value is zero (0x0) MUST abort initialization and
>>>   MUST NOT access any other register.
>>> +After writing 0 to \field{Status}, the driver MUST wait for a read of
>>> +\field{Status} to return 0 before proceeding with the remaining steps of
>>> +initializing the device.
> Maybe move this to the "MMIO Device Register Layout" driver normative
> section.
>
> Should that have a companion device normative statement (just as for
> PCI)?
>
>>> +
>>>   Drivers not expecting shared memory MUST NOT use the shared
>>>   memory registers.

