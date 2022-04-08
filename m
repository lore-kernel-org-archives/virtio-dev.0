Return-Path: <virtio-dev-return-9405-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D99E1986522
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Apr 2022 17:50:15 +0000 (UTC)
Message-ID: <12057320-17d3-cea5-5e39-4ed314702385@bytedance.com>
Date: Fri, 8 Apr 2022 18:50:13 +0100
MIME-Version: 1.0
References: <20220330152659.3780600-1-usama.arif@bytedance.com>
 <20220330152659.3780600-3-usama.arif@bytedance.com>
 <YkrIAz5R79Tsl7bv@stefanha-x1.localdomain>
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <YkrIAz5R79Tsl7bv@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [PATCH 2/4] content: Introduce driver/device aux. notification
 cfg type for PCI
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

Thanks for the reviews! I have tried to address the comments in the v2 
of the patch.
Also replying inline in this and other comment mails to further discuss 
them.

On 04/04/2022 11:27, Stefan Hajnoczi wrote:
> On Wed, Mar 30, 2022 at 04:26:57PM +0100, Usama Arif wrote:
>> +The \field{cap.offset} and \field{dev_aux_notification_off_multiplier} are taken
>> +from the device auxiliary notification capability structure above, and the
>> +\field{dev_aux_notification_idx} is the device auxiliary notification index. There is no restriction for
>> +the mapping between device auxiliary notifications and dev_aux_notification_idx. The mapping is
>> +device-specific. One possible mapping would be to use the integers 0 to
>> +N-1 as the device auxiliary notification indices for a total of N device auxiliary notifications.
>> +The total number of device auxiliary notifications exposed by the device is also device-specific.
> 
> The second half of the paragraph could be shortened to "The number of
> device auxiliary notifications and their purpose is device-specific". I
> don't think discussing the device-specific mapping and that it may be
> 0 to N-1 or something else adds anything.
>

Thanks, part of v2. Also have shortened it for MMIO.

>> +
>> +\devicenormative{\paragraph}{Device auxiliary notification capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device auxiliary notification capability}
>> +
>> +The \field{cap.offset} MUST be 2-byte aligned.
>> +
>> +The device MUST either present \field{dev_aux_notification_off_multiplier} as an
>> +even power of 2, or present \field{dev_aux_notification_off_multiplier} as 0.
>> +
>> +The value \field{cap.length} presented by the device MUST be at least 2
>> +and MUST be large enough to support device auxiliary notification offsets for all supported
>> +device auxiliary notifications in all possible configurations.
>> +
>> +The value \field{cap.length} presented by the device MUST satisfy:
>> +
>> +\begin{lstlisting}
>> +cap.length >= max_dev_aux_notification_idx * dev_aux_notification_off_multiplier + 2
>> +\end{lstlisting}
>> +
>> +where \field{max_dev_aux_notification_idx} is the maximum device auxiliary notification index and is
>> +dependent on the device.
> 
> One thought about dev aux notifications: the size is limited to 2 bytes.
> Sometimes it's useful to communicate information (i.e. 1, 2, or 4 bytes)
> as part of the notification (virtio-vhost-user may not need it but other
> users might). Perhaps the width should be device-specific and not fixed
> to 2?
> 

Yes sounds better not to limit the data width. I have changed this in 
v2. The
normatives for data width 2 and 4 in v2 are similar to
Notification capability device normative with the substituted terms for
device aux. notification, i.e. dev_aux_notification_off_multiplier 
instead of
notify_off_multiplier, etc.


>> +
>> +\subsubsection{Driver auxiliary notification capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Driver auxiliary notification capability}
>> +
>> +The Driver auxiliary notification
>> +\ref{sec:Basic Facilities of a Virtio Device / Notifications} location
>> +is found using the VIRTIO_PCI_CAP_DRIVER_AUX_NOTIFY_CFG capability. The
>> +driver auxiliary notification structure allows MSI-X vectors to be
>> +configured for notification interrupts. If MSI-X is not available, bit 2
>> +of the ISR status \ref{sec:Virtio Transport Options / Virtio Over PCI
>> +Bus / PCI Device Layout / ISR status capability} indicates that a
>> +driver auxiliary notification occurred.
> 
> Is there any way to determine which driver auxiliary notification
> occurred when MSI-X is not available? Please make this clear in the
> text.
> 

The only thing that comes to mind is using additional ISR bits to indicate
which driver aux. notification occured, but that probably is a bad idea?

So it means that only a single driver aux. notification
can be supported if MSI-X is not available as its not possible to 
distinguish
between them.

The same situation arises in vritio-mmio as well, so only a single 
driver aux. notification
can be supported there as well i think.

I have updated this in v2, but just wanted to check if you have an idea on
how to support multiple types of driver aux. notifications in non MSI-X 
and virtio-mmio case?
>> +
>> +The driver auxiliary notification structure is the following:
>> +
>> +\begin{lstlisting}
>> +struct virtio_pci_driver_aux_notification_cfg {
>> +	le16 driver_aux_notification_select;              /* read-write */
>> +	le16 driver_aux_notification_msix_vector;         /* read-write */
>> +};
>> +\end{lstlisting}
>> +
>> +The driver indicates which notification is of interest by writing the
>> +\field{driver_aux_notification_select} field. The driver then writes the MSI-X
>> +vector or VIRTIO_MSI_NO_VECTOR to \field{driver_aux_notification_msix_vector} to
>> +change the MSI-X vector for that notification.
>> +
>> +The mapping between notifications and notification indices is
>> +device-specific. The total number of notifications is also
>> +device-specific.
>> +
>> +\devicenormative{\paragraph}{Driver auxiliary notification capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Driver auxiliary notification capability}
>> +
>> +Device MUST ignore writes to \field{driver_aux_notification_msix_vector} if the
>> +value written to \field{driver_aux_notification_select} is not a valid notification
>> +index.
>> +
>> +Device MUST return VIRTIO_MSI_NO_VECTOR for reads from
>> +\field{driver_aux_notification_msix_vector} if the value written to
>> +\field{driver_aux_notification_select} is not a valid notification index.
> 
> Maybe the spec should say something about the minimum number of MSI-X
> vectors presented by the device?
> 
>    num_vectors >= 1 /* config change */ + num_vqs + num_driver_aux_notifications

I have added this in v2 in MSI-X Vector Configuration device normative.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

