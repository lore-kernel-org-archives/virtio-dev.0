Return-Path: virtio-dev-return-3844-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 862F2581911F
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Apr 2018 18:30:42 -0700 (PDT)
References: <20180416130526.6233-1-sameeh@daynix.com>
 <20180416130526.6233-3-sameeh@daynix.com>
From: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>
Message-ID: <cb72bb71-f6d5-838f-33da-8b58f9f41486@oracle.com>
Date: Mon, 16 Apr 2018 18:30:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180416130526.6233-3-sameeh@daynix.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v2 2/2] content: net: steering mode: Add RSS
To: Sameeh Jubran <sameeh@daynix.com>, virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 4/16/2018 6:05 AM, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
>
> This commit introduces the RSS feature into virtio-net. It is introduced
> as a sub mode for a general command which configures the steering mode.
>
> Most modern high end network devices today support configurable hash functions,
> this commit introduces RSS - Receive Side Scaling - [1] to virtio net device.
>
> The RSS is a technology from Microsoft that boosts network device performance
> by efficiently distributing the traffic among the CPUs in a multiprocessor
> system.
>
> This feature is supported in most of the modern network cards as well as most
> modern OSes including Linux and Windows. It is worth mentioning that both DPDK
> and Hyper-v support RSS too.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/network/ndis-receive-side-scaling2
>
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>   content.tex | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 114 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 3d538e8..8076147 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4017,6 +4017,7 @@ The device MUST NOT queue packets on receive queues greater than
>   \begin{lstlisting}
>   // steering mode flags
>   #define STEERING_MODE_AUTO          1
> +#define STEERING_MODE_RSS           2
>   
>   struct virtio_net_steering_modes {
>   le32 steering_modes;
> @@ -4027,6 +4028,7 @@ le32 steering_mode;
>   le32 command;
>   
>       union {
> +    struct virtio_net_rss rss_conf;
>       }
>   };
>   
> @@ -4066,6 +4068,118 @@ If this feature has been negotiated, the virtio header has an additional
>   
>   This is the default steering mode, please refer to the "Automatic receive steering in multiqueue" section.
>   
> +\subparagraph{Receive Side Scaling}{Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode / Receive Side Scaling}
> +
> +\begin{lstlisting}
> +#define RSS_HASH_FUNCTION_NONE      1
> +#define RSS_HASH_FUNCTION_TOEPLITZ  2
> +#define RSS_HASH_FUNCTION_SYMMETRIC 3
Above are bit fields?  Should it be 0x1, 0x2, 0x4 etc.,
> +
> +// Hash function fields
> +#define RSS_HASH_FIELDS_IPV4          0x00000100
> +#define RSS_HASH_FIELDS_TCP_IPV4      0x00000200
> +#define RSS_HASH_FIELDS_IPV6          0x00000400
> +#define RSS_HASH_FIELDS_IPV6_EX       0x00000800
> +#define RSS_HASH_FIELDS_TCP_IPV6      0x00001000
> +#define RSS_HASH_FIELDS_TCP_IPV6_EX   0x00002000
> +
> +struct virtio_net_rss_supported_hash{
> +le32 hash_function;
> +}
> +
> +struct virtio_net_rss {
> +le32 hash_function;
> +le32 hash_function_flags;
> +le32 hash_key_length;
> +le32 indirection_table_length;
> +	struct {
> +		le32 hash_key[hash_key_length];
> +		le32 indirection_table[indirection_table_length];
> +	}
> +};
> +
> +#define VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
> +#define VIRTIO_NET_SM_CTRL_RSS_SET                       1
> +\end{lstlisting}
> +
> +If the VIRTIO_NET_F_CTRL_STEERING_MODE is negotiated the driver can send control
> +commands for the RSS configuration. For configuring RSS the virtio_net_steering_mode
> +should be filled. The \field{steering_mode} field should be filled with the STEERING_MODE_RSS
> +flag along with one of the VIRTIO_NET_SM_CTRL_RSS commands in the \field{command} field. The
> +\field{rss_conf} field should be used.
> +
> +The class VIRTIO_NET_CTRL_RSS has two commands:
> +
> +\begin{enumerate}
> +\item VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS returns the hash functions
> +	supported by the device to the driver.
> +\item VIRTIO_NET_SM_CTRL_RSS_SET applies the new RSS configuration. The command is
> +	used by the driver for setting RSS hash function, hash key and
> +	indirection table in the device.
> +\end{enumerate}
> +
> +\devicenormative{\subparagraph}{Receive Side Scaling}{Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode / Receive Side Scaling}
> +
> +The device MUST fill the virtio_net_rss_supported_hash structure with the hash
> +functions it supports and return the structure to the driver. Zero or more
> +flags of the RSS_HASH_FUNCTION flags MUST be used to fill the \field{hash_function}
> +field.
> +
> +The device MUST drop all previous RSS configuration upon receiving
> +VIRTIO_NET_SM_CTRL_RSS_SET command.
> +
> +The device MUST set the RSS configuration according to the settings provided as
> +follows, once the configuration process is completed the device SHOULD apply
> +the hash function to each of the incoming packets and distribute the packets
> +through the virqueues using the calculated hash and the indirection table
> +that were earlier provided by the driver.
> +
> +Setting RSS configuration
> +\begin{enumerate}
> +\item The driver fills all of the fields and passes them through the control
> +	queue to the device.
> +
> +\item The device sets the RSS configuration as provided by the driver.
> +
> +\item If the device successfully applied the configuration, on each packet
> +	received the device MUST calculate the hashing for the packet and
calculate the hash for the packet..
> +	store it in the virtio-net header in the \field{hash} field and the
> +	hash fields used in the calculation in rss_hash_type.
"rss_hash_type" carryover from previous (v1) patch?  May be should say:

  MUST calculate the hash for the packet using fields specified in hash_function_flags

> +\end{enumerate}
> +
> +In case of any unexpected values/ unsupported hash function the driver
> +MUST return VIRTIO_NET_ERR in the \field{ack} field.
> +
> +\drivernormative{\subparagraph}{Receive Side Scaling}{Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode / Receive Side Scaling}
> +
> +If the driver wants to set RSS hash it should fill the RSS structure fields
> +as follows:
> +
> +\begin{itemize}
> +\item The driver SHOULD choose the hash function that SHOULD be used and fill
> +	it in the \field{hash_function} field along with the appropriate flags
> +	in the \field{hash_function_flags} field. These flags indicate to the
> +	device which packet fields MUST be used in the calculation process of
> +	the hash.
> +\item Once the hash function has been chosen a suitable hash key should be set
> +	in the \field{hash_key} field, the length of the key should be stored
> +	in the \field{hash_key_length} field.
> +\item Lastly the driver should fill the indirection table array in the
> +	\field{indirection_table} field while setting the array length in
> +	\field{indirection_table_length}. This structure is used by the device
> +	for determining in which RX virt queue the packet should be placed.
> +\end{itemize}
> +Once the configuration phase is over successfully, the packets SHOULD have the
> +\field{hash} field with the hash value that was calculated by the device.
> +
> +Whenever the driver wants to discard the current RSS settings, it can send an
> +VIRTIO_NET_SM_CTRL_RSS_SET command along with rss structure that has
> +RSS_HASH_FUNCTION_NONE the \field{hash_function} field.
> +
> +The driver MUST check the \field{ack} field value provided by the device, in
> +case the value is not VIRTIO_NET_OK then the driver MUST handle failure and
> +retry another hash function or else give up.
> +
>   \subparagraph{Legacy Interface: Automatic receive steering in multiqueue mode}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Legacy Interface: Automatic receive steering in multiqueue mode}
>   When using the legacy interface, transitional devices and drivers
>   MUST format \field{virtqueue_pairs}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

