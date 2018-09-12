Return-Path: virtio-dev-return-4838-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9352985D0B
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Sep 2018 15:17:52 +0000 (UTC)
References: <1534358955-35869-1-git-send-email-sridhar.samudrala@intel.com>
 <20180907173251-mutt-send-email-mst@kernel.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <9bc2db49-77ea-1391-b964-a29da44ff617@intel.com>
Date: Wed, 12 Sep 2018 08:17:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180907173251-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: cohuck@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 9/7/2018 2:34 PM, Michael S. Tsirkin wrote:
> On Wed, Aug 15, 2018 at 11:49:15AM -0700, Sridhar Samudrala wrote:
>> VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
>> device to act as a standby for another device with the same MAC address.
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/18
> Applied but when do you plan to add documentation as pointed
> out by Jan and Halil?

I thought additional documentation will be done as part of the Qemu enablement
patches and i hope someone in RH is looking into it.

Does it make sense to add a link to to the kernel documentation of this feature in
the spec
  https://www.kernel.org/doc/html/latest/networking/net_failover.html


>
>> ---
>>   content.tex | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index be18234..42a0e7e 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -2525,6 +2525,9 @@ features.
>>   
>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>> +
>> +\item[VIRTIO_NET_F_STANDBY(62)] Device may act as a standby for a primary
>> +    device with the same MAC address.
>>   \end{description}
>>   
>>   \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device / Feature bits / Feature bit requirements}
>> @@ -2614,6 +2617,9 @@ level ethernet header length) size with \field{gso_type} NONE or ECN, and do
>>   so without fragmentation, after VIRTIO_NET_F_MTU has been successfully
>>   negotiated.
>>   
>> +If the driver negotiates the VIRTIO_NET_F_STANDBY feature, the device MAY act
>> +as a standby device for a primary device with the same MAC address.
>> +
>>   \drivernormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
>>   
>>   A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
>> @@ -2636,6 +2642,8 @@ If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
>>   size exceeding the value of \field{mtu} (plus low level ethernet header length)
>>   with \field{gso_type} NONE or ECN.
>>   
>> +A driver SHOULD negotiate the VIRTIO_NET_F_STANDBY feature if the device offers it.
>> +
>>   \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>   \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
>>   When using the legacy interface, transitional devices and drivers
>> -- 
>> 2.14.4
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

