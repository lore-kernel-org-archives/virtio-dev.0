Return-Path: virtio-dev-return-6705-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2A899847E3
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Feb 2020 09:21:15 +0000 (UTC)
References: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
 <20200106161836.GB350142@stefanha-x1.localdomain>
 <f691fb60-8f59-e827-6a5f-569db29e0a39@linux.intel.com>
 <20200110095217.GB573283@stefanha-x1.localdomain>
 <801cf09a-759f-b6bf-e71b-02dbf0f1d513@linux.intel.com>
 <20200122165637.GD677983@stefanha-x1.localdomain>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <46df15c3-5643-f3f1-b0c2-36c451d10875@linux.intel.com>
Date: Mon, 10 Feb 2020 17:21:11 +0800
MIME-Version: 1.0
In-Reply-To: <20200122165637.GD677983@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev][PATCH v1 1/2] virtio-mmio: Add MSI and different
 notification address support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, linux-kernel@vger.kernel.org, Chao Peng <chao.p.peng@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/23/2020 12:56 AM, Stefan Hajnoczi wrote:
> On Mon, Jan 13, 2020 at 07:54:06PM +0800, Liu, Jing2 wrote:
>>>>>>         \end{note}
>>>>>>       }
>>>>>>       \hline
>>>>>> @@ -1671,25 +1671,23 @@ \subsection{MMIO Device Register Layout}\lab=
el{sec:Virtio Transport Options / Vi
>>>>>>         accesses apply to the queue selected by writing to \field{Qu=
eueSel}.
>>>>>>       }
>>>>>>       \hline
>>>>>> -  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
>>>>>> -    Writing a value to this register notifies the device that
>>>>>> -    there are new buffers to process in a queue.
>>>>>> +  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
>>>>>> +    Reading from the register returns the virtqueue notification co=
nfiguration.
>>>>>> -    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>>>>>> -    the value written is the queue index.
>>>>>> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO=
-specific Initialization And Device Operation / Notification Address}
>>>>>> +    for the configuration format.
>>>>>> -    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>>>>>> -    the \field{Notification data} value has the following format:
>>>>>> +    Writing when the notification address calculated by the notific=
ation configuration
>>>>>> +    is just located at this register.
>>>>> I don't understand this sentence.  What happens when the driver write=
s
>>>>> to this register?
>>>> We're trying to define the notification mechanism that, driver MUST re=
ad
>>>> 0x50 to get the notification configuration
>>>>
>>>> and calculate the notify address. The writing case here is that, the n=
otify
>>>> address is just located here e.g. notify_base=3D0x50, notify_mul=3D0.
>>> I still don't understand what this means.  It's just an English issue
>>> and it will become clear if you can rephrase what you're saying.
>> Sure, let me try to explain it. :)
>>
>> The different notification locations are calculated via the structure
>> returned by reading this register.
>>
>> le32 {
>>  =C2=A0=C2=A0=C2=A0 notify_base : 16;
>>  =C2=A0=C2=A0=C2=A0 notify_multiplier : 16;
>> };
>>
>> location=3Dnotify_base + queue_index * notify_multiplier
>>
>> The location might be the same when mul=3D0, and furthermore, it might b=
e
>> equal to 0x50 (notify_base=3D0x50, notify_mul=3D0) so we make this regis=
ter W
>> too.
>>
>> So we said, the register is RW and W is only for such scenario.
>>
>> Feel free to tell me if it's still confusing.
> I understand now:
>
>    Devices that only require a single notify address may set
>    notify_base=3D0x50 and notify_multiplier=3D0 to use the Queue Notifier
>    register itself for notifications.  In this case the driver writes to
>    Queue Notifier to notify the device that there are new buffers in a
>    virtqueue.
>
> Perhaps you could include this in the text.

Thanks for the guide. Since v2 was sent out, we'll add such text in=20
later version.

Jing

>>>>>> -    \lstinputlisting{notifications-le.c}
>>>>>> -
>>>>>> -    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Vi=
rtqueues / Driver notifications}
>>>>>> -    for the definition of the components.
>>>>>> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO=
-specific Initialization And Device Operation / Available Buffer Notificati=
ons}
>>>>>> +    to see the notification data format.
>>>>>>       }
>>>>>>       \hline
>>>>>>       \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
>>>>>>         Reading from this register returns a bit mask of events that
>>>>>> -    caused the device interrupt to be asserted.
>>>>>> +    caused the device interrupt to be asserted. This is only used
>>>>>> +    when MSI is not enabled.
>>>>>>         The following events are possible:
>>>>>>         \begin{description}
>>>>>>           \item[Used Buffer Notification] - bit 0 - the interrupt wa=
s asserted
>>>>>> @@ -1703,7 +1701,7 @@ \subsection{MMIO Device Register Layout}\label=
{sec:Virtio Transport Options / Vi
>>>>>>       \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
>>>>>>         Writing a value with bits set as defined in \field{Interrupt=
Status}
>>>>>>         to this register notifies the device that events causing
>>>>>> -    the interrupt have been handled.
>>>>>> +    the interrupt have been handled. This is only used when MSI is =
not enabled.
>>>>>>       }
>>>>>>       \hline
>>>>>>       \mmioreg{Status}{Device status}{0x070}{RW}{%
>>>>>> @@ -1762,6 +1760,31 @@ \subsection{MMIO Device Register Layout}\labe=
l{sec:Virtio Transport Options / Vi
>>>>>>         \field{SHMSel} is unused) results in a base address of
>>>>>>         0xffffffffffffffff.
>>>>>>       }
>>>>>> +  \hline
>>>>>> +  \mmioreg{MsiStatus}{MSI status}{0x0c0}{R}{%
>>>>>> +    Reading from this register returns the global MSI enable/disabl=
e status and maximum
>>>>>> +    number of virtqueues that device supports.
>>>>>> +    \lstinputlisting{msi-status.c}
>>>>>> +  }
>>>>> Why is it necessary to combine the number of virtqueues and global
>>>>> MSI enable/disable into a single 16-bit field?
>>>> Originally, we want this 16-bit Read-Only, so we put some RO things to=
gether
>>>> and separate
>>>>
>>>> enable setting command to next register.
>>>>
>>>>> virtio-mmio uses 32-bit registers.  It doesn't try hard to save regis=
ter
>>>>> space so it's strange to do it here (11-bit number of virtqueue field
>>>>> but 32-bit QueueSel field).
>>>> In order to improve performance/save register space,=C2=A0 we combine =
some data
>>>> together.
>>>>
>>>> For example, combine MSI cmd operator (e.g. enable/disable, vector set=
up)
>>>> with argument (e.g. 1/0,=C2=A0 queue index).
>>>>
>>>> But it seems we miss the consistency with QueueSel.=C2=A0 So do you th=
ink if the
>>>> max queue number should be 32-bit,
>>>>
>>>> which means it must be the same with QueueSel? If so, I guess we need =
some
>>>> re-organization. :)
>>> I suggest following the 32-bit register size convention unless there is
>>> a specific reason why using other register sizes is absolutely necessar=
y.
>> Yes, let's keep consistency with QueueSel and re-organize other register=
s.
>>
>> I feel concern why Available Bu=EF=AC=80er Notifcations (section describ=
ing
>> VIRTIO_F_NOTIFICATION_DATA) makes vq index as 16bit?
> As you mentioned, the valid range of virtqueue numbers is only 16 bits
> due to non-MMIO parts of the specification using 16 bits.
>
> However, I think it makes sense to stick to the MMIO transport 32-bit
> register size convention for consistency.  Devices just won't support
> values above 0xffff.
>
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

