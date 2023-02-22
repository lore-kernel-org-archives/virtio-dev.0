Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <32675f1a-5da4-dc78-a03f-8c173f59c7da@linux.alibaba.com>
Date: Wed, 22 Feb 2023 10:34:39 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] RE: [PATCH v9] virtio-net: support inner header hash
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221115147-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815A89628D17FA1F455F2BDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54815A89628D17FA1F455F2BDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



在 2023/2/22 上午3:29, Parav Pandit 写道:
>
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Tuesday, February 21, 2023 12:06 PM
>>
>> On Tue, Feb 21, 2023 at 04:20:59AM +0000, Parav Pandit wrote:
>>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>>> Sent: Saturday, February 18, 2023 9:37 AM
>>>> If the tunnel is used to encapsulate the packets, the hash
>>>> calculated using the
>>> s/hash calculated/hash is calculated
>>>
>>>> outer header of the receive packets is always fixed for the same
>>>> flow packets, i.e. they will be steered to the same receive queue.
>>>>
>>> A little descriptive commit message like below reads better to me.
>>> Currently, when a received packet is an encapsulated packet meaning there
>> is an outer and an inner header, virtio device is unable to calculate the hash for
>> the inner header.
>>> Due to this limitation, multiple different flows identified by the inner header
>> for the same outer header result in selecting the same receive queue.
>>> This effectively disables the RSS, resulting in poor receive performance.
>>>
>>> Hence, to overcome this limitation, a new feature is introduced using a
>> feature bit VIRTIO_NET_F_HASH_TUNNEL.
>>> This feature enables the device to advertise the capability to calculate the
>> hash for the inner packet header.
>>> Thereby regaining better RSS performance in presence of outer packet
>> header.
>>
>> I think this is a good description however Parav I think it is important to make
>> contributors write their own commit messages so they know what is the reason
>> for the proposed change.
> Sure. Contributor can rewrite it.
>
>> What's good for the goose is good for the gander -
>> contributors should explain why their change to spec is benefitial but reviewers
>> should also explain why their changes to the patch are benefitial, and "reads
>> better to me" does not cut it - it does not allow the contributor to improve with
>> time.  It's more than about a single contribution, see?
>>
> I provided an example template on how to write problem_description -> solution commit log.
>
> At the beginning, I said "little descriptive" to explain why it reads better.
> But it seems, even more verbosity is needed even for the reviewer to suggest.
> I didn't see this often happening by other reviewers, but I make a note of it now, at least I can improve from this feedback.
>
> I imagined that the contributor would see the pattern as problem->solution in the example commit log and follow in the future patches.

Yes, we describe commits in the "as is -> problem -> solution" pattern, 
and it's good to refer to some better examples for clarity.

> Giving example of current patch was best to describe how to write it.
>
>> In this case I would say the issue is that motivation for the change is never
>> explained.
>>> When a specific receive queue is shared to receive packets of multiple
>> tunnels, there is no quality of service for packets of multiple tunnels.
>>
>> "shared to receive" is not grammatical either :)
>>
> "Shared by multiple tunnels" will make it grammatical?
>
>> If you are talking about a security risk you need to explain
>> 1- what is the threat, what configurations are affected.
>> 2- what is the attack type: DOS, information leak, etc.
>> 3- how to mitigate it
>>
>> This text touches a bit on 1 and 2 but not in an ordererly way.
>>
>>
> it is best effort based.
>
> #3 is outside the scope of this patch set.
>
>>> +
>>>> +This can pose several security risks:
>>>> +\begin{itemize}
>>>> +\item  Encapsulated packets in the normal tunnels cannot be
>>>> +enqueued due to
>>>> queue
>>>> +       overflow, resulting in a large amount of packet loss.
>>>> +\item  The delay and retransmission of packets in the normal
>>>> +tunnels are
>>>> extremely increased.
>>> This is something very protocol specific and doesn't belong here.
>> I don't see how it's specific - many protocols have retransmission and are
>> affected by delays. "extremely increased" sounds unrammatical to me though.
>>
>>
> I am not sure where you want to lead this discussion.
> I am trying to help the spec and feature definition to be compact enough to progress.

Thanks!

>
> It is specific to a protocol(s) and somehow arbitrarily concluded with a large number of packet losses.
> Maybe only one ICMP packet got dropped and retransmit was just one packet.
> Maybe it was TCP with selective retransmit enabled/disabled.
>
> As far as receive side is concerned, it should say that there is no QoS among different tunnels.
> The user will figure out how to mitigate when such QoS is not available. Either to run in best-effort mode or mitigate differently.

Yes, our cloud security and cloud network team will configure and use 
inner hash on dpdk. In fact I discussed with them the security issues 
between tunnels,
and I will quote their solutions to tunnel attacks below, but this is a 
problem between the tunnels, not the introduction of inner hash.
I don't think we need to focus too much on this, but I'll do my best to 
describe the security issues between tunnels in v10.

"
This is not a problem with the inner hash, it is a general problem with 
the outer hash.
I communicated with our people who are doing cloud security (they are 
also one of the demanders of inner hash),
and it is a common problem for one tunnel to attack another tunnel.

For example, there is a tunnel t1; a tunnel t2; a tunnel endpoint VTEP0, 
and the vni id of t1 is id1, and the vni id of v2 is id2; a VM.

At this time, regardless of the inner hash or the outer hash, the 
traffic of tunnel t1 and tunnel t2 will reach the VM through VTEP0 
(whether it is a single queue or multiple queues),
and may be placed on the same queue to cause queue overflow.

# Solutions:
1. Some current forwarding tools such as DPDK have good forwarding 
performance, and it is difficult to fill up the queue;
2. or switch the attack traffic to the attack clusters;
3. or connect the traffic of different tunnels to different network card 
ports or network devices.
4..
"

>
>>>> +\item  The user can observe the traffic information and enqueue
>>>> +information
>>>> of other normal
>>>> +       tunnels, and conduct targeted DoS attacks.
>>> Once hash_report_tunnel_types is removed, this second attack is no longer
>> applicable.
>>> Hence, please remove this too.
>>
>> ?
>> I don't get how removing a field helps DoS.
>>
> I meant for the "observe and enqueue" part of the tunnel as not applicable.
>
>> \begin{lstlisting}  struct virtio_net_rss_config {
>>>>       le32 hash_types;
>>>> +    le32 hash_tunnel_types;
>>> This field is not needed as device config space advertisement for the support
>> is enough.
>>> If the intent is to enable hashing for the specific tunnel(s), an individual
>> command is better.
>>
>> new command? I am not sure why we want that. why not handle tunnels like
>> we do other protocols?
> I didn't follow.
> We probably discussed in another thread that to set M bits, it is wise to avoid setting N other bits just to keep the command happy, where N >>> M and these N have a very strong relation in hw resource setup and packet steering.
> Any examples of 'other protocols'?
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

