Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <c41d25a2-3093-6c4a-c29e-b370fb9bd3d9@nvidia.com>
Date: Wed, 1 Jun 2022 17:46:52 +0300
Subject: Re: [PATCH v5 5/7] Add miscellaneous configuration structure for PCI
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-6-mgurtovoy@nvidia.com>
 <20220515104346-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220515104346-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/15/2022 5:49 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 27, 2022 at 01:58:22AM +0300, Max Gurtovoy wrote:
>> This new structure will be used for adding new miscellaneous registers
>> for a virtio device configuration layout.
>>
>> For now, only admin_queue_index register is added. Admin virtqueue index
>> does not depend on the device type. Hence, add a PCI capability to read
>> the admin virtqueue index.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   conformance.tex |  2 ++
>>   content.tex     | 29 +++++++++++++++++++++++++++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/conformance.tex b/conformance.tex
>> index 3c7b7bc..c183581 100644
>> --- a/conformance.tex
>> +++ b/conformance.tex
>> @@ -103,6 +103,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
>>   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
>>   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
>> +\item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>>   \end{itemize}
>>   
>>   \conformance{\subsection}{MMIO Driver Conformance}\label{sec:Conformance / Driver Conformance / MMIO Driver Conformance}
>> @@ -364,6 +365,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
>>   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
>>   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
>> +\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>>   \end{itemize}
>>   
>>   \conformance{\subsection}{MMIO Device Conformance}\label{sec:Conformance / Device Conformance / MMIO Device Conformance}
>> diff --git a/content.tex b/content.tex
>> index 163cb34..0c1d44f 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -712,6 +712,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>>   \item ISR Status
>>   \item Device-specific configuration (optional)
>>   \item PCI configuration access
>> +\item Miscellaneous configuration
>>   \end{itemize}
>>   
>>   Each structure can be mapped by a Base Address register (BAR) belonging to
>> @@ -771,6 +772,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>>   #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>>   /* Vendor-specific data */
>>   #define VIRTIO_PCI_CAP_VENDOR_CFG        9
>> +/* Miscellaneous configuration */
>> +#define VIRTIO_PCI_CAP_MISC_CFG          10
>>   \end{lstlisting}
>>   
>>           Any other value is reserved for future use.
>> @@ -1352,6 +1355,32 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
>>   specified by some other Virtio Structure PCI Capability
>>   of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
>>   
>> +\subsubsection{Miscellaneous configuration structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>> +
>> +The miscellaneous configuration structure is found at the bar and offset within the VIRTIO_PCI_CAP_MISC_CFG capability.
> not very clear what is within what.
>
> Simplify the sentence:
>
> The VIRTIO_PCI_CAP_MISC_CFG specifies the location of The miscellaneous
> configuration structure.
>
>> +Its layout is below.
> who's layout? and try to avoid using "below".
> better:
>
> The miscellaneous configuration structure has the following layout
>
>> +\begin{lstlisting}
>> +struct virtio_pci_misc_cfg {
>> +        le16 admin_queue_index;         /* read-only for driver */
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{description}
>> +\item[\field{admin_queue_index}]
>> +        The device uses this to report the index of the admin virtqueue.
>> +        This field is valid only if VIRTIO_F_ADMIN_VQ is set.
>> +\end{description}
>> +
>> +\devicenormative{\paragraph}{Miscellaneous configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>> +The device MUST present VIRTIO_PCI_CAP_MISC_CFG capability when VIRTIO_F_ADMIN_VQ is set.
>> +
>> +The device MUST present a valid \field{admin_queue_index} when VIRTIO_F_ADMIN_VQ is set.
>> +
> set meaning "offered"?
>
>> +\drivernormative{\paragraph}{Miscellaneous configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>> +The driver MUST NOT proceed with configuring the admin virtqueue in case VIRTIO_F_ADMIN_VQ is set and VIRTIO_PCI_CAP_MISC_CFG capability is not present.
> "set" is vague. do you mean "negotiated"?
>
> also then let's mandate not negotiating VIRTIO_F_ADMIN_VQ.
>
> also if you are addressing this, address the reverse case
> what to do without VIRTIO_F_ADMIN_VQ but with the capability.

is the below good enough ?

"

\devicenormative{\paragraph}{Miscellaneous configuration structure 
layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device 
Layout / Miscellaneous configuration structure layout}
The device MUST present VIRTIO_PCI_CAP_MISC_CFG capability when 
VIRTIO_F_ADMIN_VQ is offered.

The device MUST present a valid \field{admin_queue_index} when 
VIRTIO_F_ADMIN_VQ is offered.

\drivernormative{\paragraph}{Miscellaneous configuration structure 
layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device 
Layout / Miscellaneous configuration structure layout}
The driver MUST NOT negotiate VIRTIO_F_ADMIN_VQ if 
VIRTIO_PCI_CAP_MISC_CFG capability is not present.

The driver MAY proceed with other configuration steps in case 
VIRTIO_F_ADMIN_VQ isn't offered and VIRTIO_PCI_CAP_MISC_CFG is present.

The driver MUST use the value of \field{admin_queue_index} to configure 
the admin virtqueue, if VIRTIO_F_ADMIN_VQ negotiated and 
VIRTIO_PCI_CAP_MISC_CFG is present.
For more details on virtqueue configuration see section \ref{sec:Virtio 
Transport Options / Virtio Over PCI Bus / PCI-specific Initialization 
And Device Operation / Device Initialization / Virtqueue Configuration}.

"


>
>
>> +
>> +The driver MUST use the value of \field{admin_queue_index} to configure the admin virtqueue. For more details on virtqueue configuration see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration}.
>> +
>>   \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
>>   
>>   Transitional devices MUST present part of configuration
>> -- 
>> 2.21.0

