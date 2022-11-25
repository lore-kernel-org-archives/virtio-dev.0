Return-Path: <jasowang@redhat.com>
Message-ID: <4bb0aac7-68f9-d279-1450-3e395913b7b0@redhat.com>
Date: Fri, 25 Nov 2022 11:27:49 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 05/10] pci: add admin vq registers to virtio over pci
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-6-mst@redhat.com>
 <CACGkMEudncpBmbo7ypDdo391Sf5Y7_5AAnwz3YG2rPk6G_qMRQ@mail.gmail.com>
 <20221124021302-mutt-send-email-mst@kernel.org>
 <CACGkMEsVCHmu24gaY2nG3kj8cBaRZVXD0a0kxFF-6PCWmsM8dQ@mail.gmail.com>
 <20221124030416-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221124030416-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/11/24 16:09, Michael S. Tsirkin 写道:
> On Thu, Nov 24, 2022 at 03:46:00PM +0800, Jason Wang wrote:
>> On Thu, Nov 24, 2022 at 3:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Thu, Nov 24, 2022 at 02:00:54PM +0800, Jason Wang wrote:
>>>> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> Add new registers to the PCI common configuration structure.
>>>>>
>>>>> These registers will be used for querying the indices of the admin
>>>>> virtqueues of the owner device. To configure, reset or enable the admin
>>>>> virtqueues, the driver should follow existing queue configuration/setup
>>>>> sequence.
>>>>>
>>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>>   content.tex | 34 ++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 34 insertions(+)
>>>>>
>>>>> diff --git a/content.tex b/content.tex
>>>>> index 04235da..aa68926 100644
>>>>> --- a/content.tex
>>>>> +++ b/content.tex
>>>>> @@ -946,6 +946,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>>>>           le64 queue_device;              /* read-write */
>>>>>           le16 queue_notify_data;         /* read-only for driver */
>>>>>           le16 queue_reset;               /* read-write */
>>>>> +
>>>>> +        /* About the administration virtqueue. */
>>>>> +        le16 admin_queue_index;         /* read-only for driver */
>>>>> +        le16 admin_queue_num;         /* read-only for driver */
>>>> If we are adding more queue related functionality, it would be placed
>>>> under the above two fields which seems not elegant. I wonder if a new
>>>> structure is needed here.
>>>>
>>>> Thanks
>>> I don't expect more, if that happens we can always refactor it.
>> I may miss something but it should be a part of ABI. How could we
>> refactor it without breaking ABI?
>>
>> Thanks
>           /* About the administration virtqueue. */
> -        le16 admin_queue_index;         /* read-only for driver */
> -        le16 admin_queue_num;         /* read-only for driver */
> +        struct { /* read-only for driver */
> +        	le16 index;
> +        	le16 num;
> +	 } admin_queue;
>
> does not affect the ABI. But the order of things makes it less readable.


Yes, so I basically meant if we need a dedicated capability for admin 
virtqueue.

(Btw, I wonder if we need a sentence to document the implication for 
notification area, e.g if vendor choose to use a large index but still 
want to use page-per-vq notification area).


>
> We would also have to change references to admin_queue_index with
> admin_queue.index and explain the "." notation in introduction.
>
>
> All doable but this patchset is large enough as it is.


Can we split the PCI part on top?

Thanks


>
>
>
>>> Generally this is not C, no one compiles this directly.
>>> So we do not need to add structures unless
>>> they are referred to in spec text.
>>>
>>>>>   };
>>>>>   \end{lstlisting}
>>>>>
>>>>> @@ -1031,6 +1035,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>>>>           This field exists only if VIRTIO_F_RING_RESET has been
>>>>>           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>>>>>
>>>>> +\item[\field{admin_queue_index}]
>>>>> +        The device uses this to report the index of the first administration virtqueue.
>>>>> +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
>>>>> +\item[\field{admin_queue_num}]
>>>>> +       The device uses this to report the number of the
>>>>> +       supported administration virtqueues.  Virtqueues with index
>>>>> +       between \field{admin_queue_index} and (\field{admin_queue_index} +
>>>>> +       \field{admin_queue_num}) inclusive serve as administration
>>>>> +       virtqueues.
>>>>> +       Thus the number of administration virtqueues equals
>>>>> +       (\field{admin_queue_num} + 1).
>>>>> +       This field is valid only if VIRTIO_F_ADMIN_VQ has been
>>>>> +       negotiated.
>>>>>   \end{description}
>>>>>
>>>>>   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
>>>>> @@ -1117,6 +1134,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>>>>   were used before the queue reset.
>>>>>   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>>>>>
>>>>> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
>>>>> +configures any administration virtqueues, the driver MUST
>>>>> +configure the administration virtqueues using the index
>>>>> +in the range \field{admin_queue_index} to
>>>>> +\field{admin_queue_index} + \field{admin_queue_num} inclusive.
>>>>> +The driver MAY configure less administration virtqueues than
>>>>> +supported by the device.
>>>>> +
>>>>>   \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>>>>>
>>>>>   The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
>>>>> @@ -6992,6 +7017,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>>>>
>>>>>     \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
>>>>>     administration virtqueues.
>>>>> +  At the moment this feature is only supported for devices using
>>>>> +  \ref{sec:Virtio Transport Options / Virtio Over PCI
>>>>> +         Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
>>>>> +         as the transport and is reserved for future use for
>>>>> +         devices using other transports (see
>>>>> +         \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}
>>>>> +       and
>>>>> +       \ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
>>>>> +       handling features reserved for future use.
>>>>>
>>>>>   \end{description}
>>>>>
>>>>> --
>>>>> MST
>>>>>

