Return-Path: virtio-dev-return-4539-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 97F6C5818EFB
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Jun 2018 06:48:43 -0700 (PDT)
References: <20180625122442.22432-1-tiwei.bie@intel.com>
 <c1215d02-918f-64af-867a-d7a21ca8f93b@linux.ibm.com>
 <20180625203654-mutt-send-email-mst@kernel.org>
 <72351a30-480e-b160-9774-c0b880230c1d@linux.ibm.com>
 <20180626002306-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 26 Jun 2018 15:48:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180626002306-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c779a1fe-0a24-63e8-ab37-eb9aa29f7040@linux.ibm.com>
Subject: Re: [virtio-dev] [RFC] content: tweak VIRTIO_F_IO_BARRIER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 06/25/2018 11:27 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 25, 2018 at 08:40:55PM +0200, Halil Pasic wrote:
>>
>>
>> On 06/25/2018 07:42 PM, Michael S. Tsirkin wrote:
>>> On Mon, Jun 25, 2018 at 06:07:17PM +0200, Halil Pasic wrote:
>>>>
>>>>
>>>> On 06/25/2018 02:24 PM, Tiwei Bie wrote:
>>>>> VIRTIO_F_IO_BARRIER was proposed recently to allow
>> [..]
>>>>> +  \item[VIRTIO_F_REAL_DEVICE(36)] This feature indicates
>>>>> +  that the device doesn't allow the driver to assume the
>>>>> +  device is implemented in software and runs on host CPU.
>>>>> +  When devices are implemented in software and run on host
>>>>> +  CPU, some optimizations can be done in drivers and yield
>>>>
>>>> s/optimizations/optimization/ ?
>>>
>>> Why?
>>>
>>
>> My spell-checker complains but after searching the internet it
>> 'optimizations' seems like a legit plural. However
>> https://en.oxforddictionaries.com/definition/optimization
>> does state 'mass noun' (that is uncountable) but then there
>> is an example with countable :S. English is not my strong
>> side.
>>
>> Regards,
>> Halil
> 
> 
> It's like e.g. coffee.
> 
> So "some optimization" means "a little".
> 
> "Some optimizations" means "not all".
> 

Thanks for the explanation.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

