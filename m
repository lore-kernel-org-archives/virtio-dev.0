Return-Path: virtio-dev-return-2997-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C75F95819169
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jan 2018 19:50:32 -0800 (PST)
Message-ID: <5A616B91.1020508@intel.com>
Date: Fri, 19 Jan 2018 11:52:49 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>	<1516170720-4948-2-git-send-email-wei.w.wang@intel.com> <871sio4qg2.fsf@secure.laptop>
In-Reply-To: <871sio4qg2.fsf@secure.laptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v1 1/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/17/2018 08:31 PM, Juan Quintela wrote:
> Wei Wang <wei.w.wang@intel.com> wrote:
>> The new feature enables the virtio-balloon device to receive the hint of
>> guest free pages from the free page vq, and clears the corresponding bits
>> of the free page from the dirty bitmap, so that those free pages are not
>> transferred by the migration thread.
>>
>> Without this feature, to local live migrate an 8G idle guest takes
>> ~2286 ms. With this featrue, it takes ~260 ms, which redues the
>> migration time to ~11%.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
> I hate to answer twice,but ...

Thanks for the second review :)

>
>
>> +static bool virtio_balloon_free_page_support(void *opaque)
>> +{
>> +    VirtIOBalloon *s = opaque;
>> +
>> +    if (!balloon_free_page_supported(s)) {
>> +        return false;
>> +    }
>> +
>> +    return true;
> return balloon_free_page_supported(s); ???

Forgot to clean this up. It is actually a duplicate of 
balloon_free_page_supported() now, I'll remove one of them in the next 
version.

>
>
>> @@ -312,6 +399,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>>   
>>       config.num_pages = cpu_to_le32(dev->num_pages);
>>       config.actual = cpu_to_le32(dev->actual);
>> +    config.free_page_report_cmd_id = cpu_to_le32(dev->free_page_report_cmd_id);
>>   
>>       trace_virtio_balloon_get_config(config.num_pages, config.actual);
>>       memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
>> @@ -418,6 +506,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
>>       .fields = (VMStateField[]) {
>>           VMSTATE_UINT32(num_pages, VirtIOBalloon),
>>           VMSTATE_UINT32(actual, VirtIOBalloon),
>> +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>>           VMSTATE_END_OF_LIST()
> No new version, no subsection, and we add a new field?
> I think that is wrong.  We need to send that only for old versions.
> Look at how was handled for ....
>
> [PATCH v2] hpet: recover timer offset correctly
>
> v2 discussion explains why we want to handle that way for different
> machine types.
>
> v3 does it correctly.

OK, I'll put it to a subsection.

>
>
> And I think that with this I have reviewed all the migration/vmstate
> bits, no?
>
> If something is missing, please ask.

Thanks. This is the only new device state that need to be saved. Please 
have a review of patch 2 as well, which makes the migration thread use 
this feature.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

