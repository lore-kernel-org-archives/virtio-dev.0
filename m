Return-Path: <virtio-comment-return-2261-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <1630034294.3513477-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5d52037a-8755-5ff8-9a7b-3a383017a5cf@redhat.com>
Date: Fri, 27 Aug 2021 11:41:11 +0800
MIME-Version: 1.0
In-Reply-To: <1630034294.3513477-1-xuanzhuo@linux.alibaba.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] virtio: introduce VIRTIO_F_RING_RESET for
 reset queue
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2021/8/27 =E4=B8=8A=E5=8D=8811:18, Xuan Zhuo =E5=86=99=E9=81=93:
> On Thu, 26 Aug 2021 12:32:34 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
>> =E5=9C=A8 2021/8/23 =E4=B8=8B=E5=8D=884:28, Xuan Zhuo =E5=86=99=E9=81=93=
:
>>> cc jasowang@redhat.com
>>>
>>> On Fri, 13 Aug 2021 10:31:05 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>>>> This patch allows the driver to reset a queue individually.
>>>>
>>>> This is very common on general network equipment. By disabling a queue=
,
>>>> you can quickly reclaim the buffer currently on the queue. If necessar=
y,
>>>> we can reinitialize the queue separately.
>>>>
>>>> For example, when virtio-net implements support for AF_XDP, we need to
>>>> disable a queue to release all the original buffers when AF_XDP setup.
>>>> And quickly release all the AF_XDP buffers that have been placed in th=
e
>>>> queue when AF_XDP exits.
>>>>
>>>> Since mmio's QueueReady allows setting 0 to stop the queue, there is n=
o
>>>> need to distinguish whether VIRTIO_F_RING_RESET is negotiated.
>>>>
>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>> ---
>>>>    content.tex | 11 ++++++++++-
>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index 7cec1c3..70a9765 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -1001,7 +1001,13 @@ \subsubsection{Common configuration structure l=
ayout}\label{sec:Virtio Transport
>>>>    After writing 0 to \field{device_status}, the driver MUST wait for =
a read of
>>>>    \field{device_status} to return 0 before reinitializing the device.
>>>>
>>>> -The driver MUST NOT write a 0 to \field{queue_enable}.
>>>> +If the VIRTIO_F_RING_RESET feature bit is not negotiated,
>>>> +the driver MUST NOT write a 0 to \field{queue_enable}.
>>>> +
>>>> +Otherwise, if the VIRTIO_F_RING_RESET feature bit is negotiated,
>>>> +the driver can stop using the queue by writing a 0 to \field{queue_en=
able} and
>>>> +MUST read the value back to ensure synchronization. Then optionally r=
e-enable
>>>> +the queue.
>>
>>
>> So I think we need to clarify what did "stop" mean here. Since you're
>> use "RESET" in the feature I guess the virtqueue state is also reset.
>> That's fine but I'm not sure if MMIO has the similar semantic.
>>
>> E.g is the virtqueue state preserved during a stop and resume?
>    "To stop using the queue the driver MUST write zero (0x0) to this Queu=
eReady
>    and MUST read the value back to ensure synchronization."
>
> Judging from the description of the spec, the more emphasis is on the sto=
p of
> the queue. It does not express whether the queue can be re-enabled.


Yes.


>
> I think MMIO also adds the judgment for VIRTIO_F_RING_RESET here. If this
> function is successfully negotiated, then MMIO also supports queue reset,
> otherwise MMIO only supports stop queue.
>
> The "stop" I understand means the destruction of all the states of the en=
tire
> queue and the release of memory. Re-enable means reallocating the memory =
as when
> the device is initialized, and synchronizing this information to the devi=
ce.
> I will improve this part of the information in the next version.
>
> Regarding the description of the state during a stop and resume, I will a=
dd it
> in the next version.


A question regarding to the semantic of "resume". I guess it means the=20
virtqueue will start from e.g avail index 0?

Thanks


>
> Thanks.
>
>> Thanks
>>
>>
>>>>    \subsubsection{Notification structure layout}\label{sec:Virtio Tran=
sport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capa=
bility}
>>>>
>>>> @@ -6672,6 +6678,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserv=
ed Feature Bits}
>>>>      transport specific.
>>>>      For more details about driver notifications over PCI see \ref{sec=
:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializati=
on And Device Operation / Available Buffer Notifications}.
>>>>
>>>> +  \item[VIRTIO_F_RING_RESET(40)] This feature indicates
>>>> +  that the driver can reset a queue individually.
>>>> +
>>>>    \end{description}
>>>>
>>>>    \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature =
Bits}
>>>> --
>>>> 2.31.0
>>>>
>>>>
>>>> ---------------------------------------------------------------------
>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

