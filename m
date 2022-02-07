Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <d9c93540-4838-c18e-12c6-9ef4dc0028de@nvidia.com>
Date: Mon, 7 Feb 2022 16:58:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220207052843-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2/7/2022 12:39 PM, Michael S. Tsirkin wrote:
> On Thu, Feb 03, 2022 at 09:57:13AM +0200, Max Gurtovoy wrote:
>> +\begin{lstlisting}
>> +struct virtio_admin_cmd {
>> +        /* Device-readable part */
>> +        u16 command;
>> +        u8 command_specific_data[];
>> +
>> +        /* Device-writable part */
>> +        u8 status;
>> +        u8 command_specific_error;
>> +        u8 command_specific_result[];
>> +};
>> +\end{lstlisting}
> ok this abstraction is an improvement, thanks!
>
> What I'd like to see is moving a bit more format to this generic structure.
>
>  From what I could gather, some commands affect a group as a whole, and
> some commands just a single member of the group. We could have a
> "destination" field for that, and a special "all of the group"
> destination for commands affecting the whole group.
>
>
> Next, trying to think about scalable iov extensions. So we
> will have groups of VFs and then SFs as the next level.
> How does one differentiate between the two?
> Maybe reserve a field for "destination type"?

For now we have only a PCI group that composed of VFs and the PF.

What you suggest, IMO is a definition of a generic virtio 
group/subsystem that I've mentioned in the discussion of V1.

Once we have virtio group - it should have a group id and them the admin 
command can have a field calld group_id for commands that are targeted 
to the whole group.

Some commands are referring to a specific device in the group so only a 
vdev_id is needed.

Some commands are even targeted to the same device to query some info 
(we have examples in this series for that), so in this case there is no 
need for vdev_id nor group_id.

So I'm sure sure we can improve common virtio_admin_cmd structure to 
have these attributes since they are not mandatory because of the 
reasons I've mentioned.

>
> The point of all this is to allow making sense of commands and
> e.g. virtualizing them for nested virt without necessarily
> knowing all of the detail about the specific command.
I don't understand this, sorry.

