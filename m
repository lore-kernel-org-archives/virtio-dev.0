Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <debdfcfd-4c4e-df2c-8ab0-0efb9e2af279@nvidia.com>
Date: Tue, 5 Apr 2022 14:20:04 +0300
Subject: Re: [virtio-comment] Re: [PATCH v1 5/5] Add miscellaneous
 configuration structure for PCI
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
 <20220302155608.24189-6-mgurtovoy@nvidia.com>
 <20220404090330-mutt-send-email-mst@kernel.org>
 <b1cae24a-ee0e-a08d-25dd-90e045a95790@nvidia.com>
 <20220404121401-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220404121401-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 4/4/2022 7:16 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 04, 2022 at 06:52:27PM +0300, Max Gurtovoy wrote:
>> On 4/4/2022 4:04 PM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 02, 2022 at 05:56:08PM +0200, Max Gurtovoy wrote:
>>>> This new structure will be used for adding new miscellaneous registers
>>>> for a virtio device configuration layout.
>>>>
>>>> For now, only admin_queue_index register is added. Admin virtqueue index
>>>> does not depend on the device type. Hence, add a PCI capability to read
>>>> the admin virtqueue index.
>>>>
>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> ---
>>>>    conformance.tex |  2 ++
>>>>    content.tex     | 25 +++++++++++++++++++++++++
>>>>    2 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/conformance.tex b/conformance.tex
>>>> index 129831c..e31645e 100644
>>>> --- a/conformance.tex
>>>> +++ b/conformance.tex
>>>> @@ -102,6 +102,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>>    \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
>>>>    \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
>>>>    \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
>>>> +\item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>>>>    \end{itemize}
>>>>    \conformance{\subsection}{MMIO Driver Conformance}\label{sec:Conformance / Driver Conformance / MMIO Driver Conformance}
>>>> @@ -363,6 +364,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>>    \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
>>>>    \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
>>>>    \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
>>>> +\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>>>>    \end{itemize}
>>>>    \conformance{\subsection}{MMIO Device Conformance}\label{sec:Conformance / Device Conformance / MMIO Device Conformance}
>>>> diff --git a/content.tex b/content.tex
>>>> index 163cb34..bf46192 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -712,6 +712,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>>>>    \item ISR Status
>>>>    \item Device-specific configuration (optional)
>>>>    \item PCI configuration access
>>>> +\item Miscellaneous configuration
>>>>    \end{itemize}
>>>>    Each structure can be mapped by a Base Address register (BAR) belonging to
>>>> @@ -771,6 +772,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>>>>    #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>>>>    /* Vendor-specific data */
>>>>    #define VIRTIO_PCI_CAP_VENDOR_CFG        9
>>>> +/* Miscellaneous configuration */
>>>> +#define VIRTIO_PCI_CAP_MISC_CFG          10
>>>>    \end{lstlisting}
>>>>            Any other value is reserved for future use.
>>>> @@ -1352,6 +1355,28 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
>>>>    specified by some other Virtio Structure PCI Capability
>>>>    of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
>>>> +\subsubsection{Miscellaneous configuration structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>>>> +
>>>> +The miscellaneous configuration structure is found at the bar and offset within the VIRTIO_PCI_CAP_MISC_CFG capability.
>>>> +Its layout is below.
>>>> +\begin{lstlisting}
>>>> +struct virtio_pci_misc_cfg {
>>>> +        le16 admin_queue_index;         /* read-only for driver */
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +\begin{description}
>>>> +\item[\field{admin_queue_index}]
>>>> +        The device uses this to report the index of the admin virtqueue.
>>>> +        This field is valid only if VIRTIO_F_ADMIN_VQ is set.
>>>> +\end{description}
>>>> +
>>>> +\devicenormative{\paragraph}{Miscellaneous configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>>>> +The device MUST present a valid \field{admin_queue_index} when VIRTIO_F_ADMIN_VQ is set.
> besides, is must have a misc config capability if it has
> VIRTIO_F_ADMIN_VQ.

admin_queue_index is part of the misc config so it implies from that.

>
>
>>>> +
>>>> +\drivernormative{\paragraph}{Miscellaneous configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
>>>> +The driver MUST use the value of \field{admin_queue_index} to configure the admin virtqueue. For more details on virtqueue configuration see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration}.
>>>> +
>>>>    \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
>>>>    Transitional devices MUST present part of configuration
>>> This is useful, but I think we'll want this for all transports then.
>> I think that adding more transports can be incremental and should be a no-go
>> for merging this patch set.
>>
>> We discussed this in the previous version and nobody had a conclusion on the
>> right approach for other transports.

oh I had a typo. I meant shouldn't be a no-go.


> I think this referred to the msi-x thing not the the
> misc config capability - this is the first version where
> that appeared, right?  Cornelia what do you think?
>
> In any case, in that case maybe besides saying it's transport-specific
> also mention that it is currently only defined for the PCI transport.

I'll try to add it, but it might not be removed from the spec when 
somebody will add another transport admin support and will forget this 
comment.


>
>>>
>>>> -- 
>>>> 2.21.0
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F&amp;data=04%7C01%7Cmgurtovoy%40nvidia.com%7Ca1d60587d07741c5050d08da16568edc%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637846858292442161%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=dWuRqSzUOaLhvJiplv2GH3GgTSBj%2BPLlYY4pRuUGI6Y%3D&amp;reserved=0
> Feedback License: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fwho%2Fipr%2Ffeedback_license.pdf&amp;data=04%7C01%7Cmgurtovoy%40nvidia.com%7Ca1d60587d07741c5050d08da16568edc%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637846858292442161%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=oKUUoOXqKpd4oaJc4AtB7FwU1wmnVv%2B2%2FLzUv%2FWwGho%3D&amp;reserved=0
> List Guidelines: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fpolicies-guidelines%2Fmailing-lists&amp;data=04%7C01%7Cmgurtovoy%40nvidia.com%7Ca1d60587d07741c5050d08da16568edc%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637846858292442161%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=cytTVlpAzn06%2BidXyenkhEx8ZhAFZZWyVPSlhVvrRHU%3D&amp;reserved=0
> Committee: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fcommittees%2Fvirtio%2F&amp;data=04%7C01%7Cmgurtovoy%40nvidia.com%7Ca1d60587d07741c5050d08da16568edc%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637846858292442161%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=a2ORe6u0we6fL%2BnG8Wqkq3BRJY8XTj0jsQQ0YKqnTCA%3D&amp;reserved=0
> Join OASIS: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fjoin%2F&amp;data=04%7C01%7Cmgurtovoy%40nvidia.com%7Ca1d60587d07741c5050d08da16568edc%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637846858292442161%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=5%2FjVkGXexgNZ%2BZq59B73tzJ6adJVqdoLvRuoCMDeoh8%3D&amp;reserved=0
>

