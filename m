Return-Path: virtio-dev-return-3864-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C3FC4581912F
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Apr 2018 14:16:33 -0700 (PDT)
References: <1524071419-32187-1-git-send-email-jonathan.helman@oracle.com>
 <20180418224625-mutt-send-email-mst@kernel.org>
From: Jonathan Helman <jonathan.helman@oracle.com>
Message-ID: <ed8b736b-6e97-c7d5-a72d-ad8526096ee9@oracle.com>
Date: Wed, 18 Apr 2018 14:16:29 -0700
MIME-Version: 1.0
In-Reply-To: <20180418224625-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH] content: document hugetlb page
 allocation counts
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mihai.carabas@oracle.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/18/2018 01:03 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 18, 2018 at 10:10:19AM -0700, Jonathan Helman wrote:
>> The Linux kernel exports the number of successful and failed
>> hugetlb page allocations via the virtio balloon driver. These
>> two counts need to be documented in this specification.
>>
>> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
> 
> Thanks!
> Would you mind opening a github issue to address that?

Done. https://github.com/oasis-tcs/virtio-spec/issues/8

Jon

> If you have to repost, you will be able to add a "Fixes:" tag
> then.
> 
>> ---
>>   content.tex | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index 7a92cb1..110ab70 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -4516,6 +4516,8 @@ struct virtio_balloon_stat {
>>   #define VIRTIO_BALLOON_S_MEMTOT   5
>>   #define VIRTIO_BALLOON_S_AVAIL    6
>>   #define VIRTIO_BALLOON_S_CACHES   7
>> +#define VIRTIO_BALLOON_S_HTLB_PGALLOC 8
>> +#define VIRTIO_BALLOON_S_HTLB_PGFAIL  9
>>           le16 tag;
>>           le64 val;
>>   } __attribute__((packed));
>> @@ -4604,6 +4606,12 @@ first buffer.
>>   \item[VIRTIO_BALLOON_S_CACHES (7)] The amount of memory, in bytes, that can be
>>     quickly reclaimed without additional I/O. Typically these pages are used for
>>     caching files from disk.
>> +
>> +\item[VIRTIO_BALLOON_S_HTLB_PGALLOC (8)] The number of successful hugetlb page
>> +  allocations in the guest.
>> +
>> +\item[VIRTIO_BALLOON_S_HTLB_PGFAIL (9)] The number of failed hugetlb page
>> +  allocations in the guest.
>>   \end{description}
>>   
>>   \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
>> -- 
>> 1.8.3.1
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

