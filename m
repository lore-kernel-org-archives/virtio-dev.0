Return-Path: virtio-dev-return-3213-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 01FDD581803F
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Feb 2018 12:29:47 -0800 (PST)
References: <cover.1512476043.git.tgolembi@redhat.com>
 <938dc32019864c9c19259bdddd64a53b6b99efef.1512476043.git.tgolembi@redhat.com>
 <20180205130824.79f570bc@fiorina>
From: Jonathan Helman <jonathan.helman@oracle.com>
Message-ID: <1e6717d5-a1bc-3409-b01f-24ea761659fb@oracle.com>
Date: Tue, 13 Feb 2018 12:29:39 -0800
MIME-Version: 1.0
In-Reply-To: <20180205130824.79f570bc@fiorina>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v2 1/1] virtio-balloon: include statistics of
 disk/file caches
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 02/05/2018 04:08 AM, Tomáš Golembiovský wrote:
> ping
> 
> On Tue,  5 Dec 2017 13:14:46 +0100
> Tomáš Golembiovský <tgolembi@redhat.com> wrote:
> 

It would be good to include the corresponding upstream kernel change in 
the commit message. This would be similar to a previous change: 
https://lists.gnu.org/archive/html/qemu-devel/2016-02/msg05555.html

>> Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
>> ---
>>   hw/virtio/virtio-balloon.c                      | 1 +
>>   include/standard-headers/linux/virtio_balloon.h | 3 ++-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index 37cde38982..8141326a51 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -50,6 +50,7 @@ static const char *balloon_stat_names[] = {
>>      [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
>>      [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
>>      [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
>> +   [VIRTIO_BALLOON_S_CACHES] = "stat-disk-caches",
>>      [VIRTIO_BALLOON_S_NR] = NULL
>>   };
>>   
>> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
>> index 9d06ccd066..7b0a41b8fc 100644
>> --- a/include/standard-headers/linux/virtio_balloon.h
>> +++ b/include/standard-headers/linux/virtio_balloon.h
>> @@ -52,7 +52,8 @@ struct virtio_balloon_config {
>>   #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
>>   #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>>   #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
>> -#define VIRTIO_BALLOON_S_NR       7
>> +#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */

I've been wondering, VIRTIO_BALLOON_S_AVAIL is not in the virtio spec 
(see Section 5.5.6.3). It seems like this header file needs to be in 
sync with the virtio spec in order to make this change.

I have a similar change to add a new statistic and was wondering this.

>> +#define VIRTIO_BALLOON_S_NR       8
>>   
>>   /*
>>    * Memory statistics structure.
>> -- 
>> 2.15.1
>>
> 
> 

You need to add your new stat to the list of stats in 
docs/virtio-balloon-stats.txt.

Jon


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

