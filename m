Return-Path: virtio-dev-return-5244-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD129985D8B
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Jan 2019 05:09:03 +0000 (UTC)
Message-ID: <5C2EEBB3.3070109@intel.com>
Date: Fri, 04 Jan 2019 13:14:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com> <1546493462-32244-2-git-send-email-wei.w.wang@intel.com> <20190103113228-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190103113228-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v1 1/2] virtio-balloon: tweak config_changed
 implementation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/04/2019 12:42 AM, Michael S. Tsirkin wrote:
> On Thu, Jan 03, 2019 at 01:31:01PM +0800, Wei Wang wrote:
>> virtio-ccw has deadlock issues with reading config registers inside the
>> interrupt context, so we tweak the virtballoon_changed implementation
>> by moving the config read operations into the related workqueue contexts.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 54 ++++++++++++++++++++---------------------
>>   1 file changed, 26 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 728ecd1..9a82a11 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -394,33 +394,15 @@ static void virtballoon_changed(struct virtio_device *vdev)
>>   {
>>   	struct virtio_balloon *vb = vdev->priv;
>>   	unsigned long flags;
>> -	s64 diff = towards_target(vb);
>> -
>> -	if (diff) {
>> -		spin_lock_irqsave(&vb->stop_update_lock, flags);
>> -		if (!vb->stop_update)
>> -			queue_work(system_freezable_wq,
>> -				   &vb->update_balloon_size_work);
>> -		spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>> -	}
>>   
>> -	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>> -		virtio_cread(vdev, struct virtio_balloon_config,
>> -			     free_page_report_cmd_id, &vb->cmd_id_received);
> There's one problem with this approach:
>
> previously updating the cmd_id_received here would immediately
> stop the report in send_free_pages.
>
> With this approach we are waiting for the wq to schedule,
> which might be blocked waiting for report to complete.
> So host can no longer quickly stop the report in progress.
>
> A simple work-around would be to set some kind of flag whenever there
> is a change interrupt, then have send_free_pages test it
> and re-read cmd_id_received.
>
> Needs to be an atomic I guess ...
>

Yes, sounds better..will update the patch.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

