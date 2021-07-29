Return-Path: <jie.deng@intel.com>
Subject: Re: [PATCH] virtio: i2c: Allow buffer less transactions
References: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
 <7c74b6aa-5d1d-8ab1-b4ca-e1f9df8b6605@intel.com>
 <20210729054712.aw76luyq7ajso35v@vireshk-i7>
 <6ea301e0-0420-f17a-c79f-8551fb840ecc@intel.com>
 <20210729062836.yonnjojkccmnu4b7@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <f0011af9-908c-f1f9-af2c-a09af69207c7@intel.com>
Date: Thu, 29 Jul 2021 14:36:11 +0800
MIME-Version: 1.0
In-Reply-To: <20210729062836.yonnjojkccmnu4b7@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/7/29 14:28, Viresh Kumar wrote:
> On 29-07-21, 14:18, Jie Deng wrote:
>> The number of descriptors required for a request will not be fixed.
> That is true today as well, as we allow 3 (write or read) or 4
> (write-read) descriptors.
>
>> If there is a descriptor sequence in the virtqueue, then you may need a
>> state machine
>>
>> to parse the sequence. For example, when you have
>>
>>
>> WR      RR        ZR
>>
>> O O I   O I I     O I
>>
>> * WR:(write request), RR (read request), ZR (zero request), O: output
>> descriptor, I: input descriptor
>>
>>
>> When you encounter "O I" combination, you have to read the element after it
>> to distinguish
>>
>> RR and ZR. Will this bring unnecessary difficulties for the backend coding ?
> I understand what you are saying, but at least all the backends that I
> have worked with (Qemu and Rust), further categorizes these into
> blocks and this is how it looks there (writing in qemu terminology):
>
> VuVirtqElement *elem = vu_queue_pop();
>
> elem->in_num and elem_out_num gives the number of out/in buffers
> there.
>
> And so there is no way one can get confused between two different
> elements and you will always know if it is WR or RR or ZR.


Then it's good. Thank you.


