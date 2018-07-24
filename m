Return-Path: virtio-dev-return-4734-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2006985C83
	for <virtio-dev@lists.oasis-open.org>; Tue, 24 Jul 2018 18:28:02 +0000 (UTC)
References: <1532365355-45245-1-git-send-email-sridhar.samudrala@intel.com>
 <20180724144351.5f8dd113.cohuck@redhat.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <054ef852-6131-b52d-9ce6-d3f95481ad80@intel.com>
Date: Tue, 24 Jul 2018 11:27:33 -0700
MIME-Version: 1.0
In-Reply-To: <20180724144351.5f8dd113.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v2] content: Introduce
 VIRTIO_NET_F_STANDBY feature
To: Cornelia Huck <cohuck@redhat.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 7/24/2018 5:43 AM, Cornelia Huck wrote:
> On Mon, 23 Jul 2018 10:02:35 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>> VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
>> device to act as a standby for a primary device with the same MAC address.
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com
>> ---
>>   content.tex | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> v2: updated standby description based on Cornelia's feedback.
>>
>> diff --git a/content.tex b/content.tex
>> index be18234..b729857 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -2525,6 +2525,9 @@ features.
>>   
>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>> +
>> +\item[VIRTIO_NET_F_STANDBY(62)] Device MAY act as a standby for a primary
>> +    device with the same MAC
> I don't think you should use MAY etc. outside a normative section, so
> s/MAY/may/

ok.


>
>>   \end{description}
>>   
>>   \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device / Feature bits / Feature bit requirements}
>> @@ -2636,6 +2639,11 @@ If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
>>   size exceeding the value of \field{mtu} (plus low level ethernet header length)
>>   with \field{gso_type} NONE or ECN.
>>   
>> +A driver SHOULD negotiate VIRTIO_NET_F_STANDBY feature if the device offers it.
> s/VIRTIO_NET_F_STANDBY feature/the VIRTIO_NET_F_STANDBY feature/

ok.


>
>> +
>> +If the driver negotiates VIRTIO_NET_F_STANDBY, the device MAY act as a standby
>> +device for a primary device with the same MAC address.
> I think the first statement needs to go into a driver normative
> section, while the second needs to go into a device normative section.

ok.


>
>> +
>>   \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>   \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
>>   When using the legacy interface, transitional devices and drivers
> I still think we need a more detailed description of how this is
> supposed to work elsewhere (i.e., outside of the normative section).
> But we can probably merge an updated version of this patch to get at
> least the feature bit reserved and documented. Thoughts?

Sure. I can submit a v3 version with the minor changes you suggested.
The detailed description of the failover mechanism can be added once qemu
patch to handle the standby feature bit is submitted and reviewed.
I am assuming someone in RH is looking into the qemu enablement patch.


>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

