Return-Path: virtio-dev-return-5977-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFB03985D18
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Aug 2019 11:47:54 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-3-nitesh@redhat.com>
 <20190814122949.4946f438.cohuck@redhat.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <c23f02b1-4bda-7dc6-9e28-4bad0a16cde6@redhat.com>
Date: Wed, 14 Aug 2019 07:47:40 -0400
MIME-Version: 1.0
In-Reply-To: <20190814122949.4946f438.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC][Patch v12 2/2] virtio-balloon: interface to support free
 page reporting
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com, david@redhat.com, mst@redhat.com, dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com, alexander.duyck@gmail.com, john.starks@microsoft.com, dave.hansen@intel.com, mhocko@suse.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/14/19 6:29 AM, Cornelia Huck wrote:
> On Mon, 12 Aug 2019 09:12:35 -0400
> Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
>> Enables the kernel to negotiate VIRTIO_BALLOON_F_REPORTING feature wit=
h
>> the host. If it is available and page_reporting_flag is set to true,
>> page_reporting is enabled and its callback is configured along with
>> the max_pages count which indicates the maximum number of pages that
>> can be isolated and reported at a time. Currently, only free pages of
>> order >=3D (MAX_ORDER - 2) are reported. To prevent any false OOM
>> max_pages count is set to 16.
>>
>> By default page_reporting feature is enabled and gets loaded as soon
>> as the virtio-balloon driver is loaded. However, it could be disabled
>> by writing the page_reporting_flag which is a virtio-balloon parameter=
=2E
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> ---
>>  drivers/virtio/Kconfig              |  1 +
>>  drivers/virtio/virtio_balloon.c     | 64 ++++++++++++++++++++++++++++=
-
>>  include/uapi/linux/virtio_balloon.h |  1 +
>>  3 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_b=
alloon.c
>> index 226fbb995fb0..defec00d4ee2 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
> (...)
>
>> +static void virtballoon_page_reporting_setup(struct virtio_balloon *v=
b)
>> +{
>> +	struct device *dev =3D &vb->vdev->dev;
>> +	int err;
>> +
>> +	vb->page_reporting_conf.report =3D virtballoon_report_pages;
>> +	vb->page_reporting_conf.max_pages =3D PAGE_REPORTING_MAX_PAGES;
>> +	err =3D page_reporting_enable(&vb->page_reporting_conf);
>> +	if (err < 0) {
>> +		dev_err(dev, "Failed to enable reporting, err =3D %d\n", err);
>> +		page_reporting_flag =3D false;
> Should we clear the feature bit in this case as well?

I think yes.
If I am not wrong then in a case where page reporting setup fails for som=
e
reason and at a later point the user wants to re-enable it then for that =
balloon
driver has to be reloaded.
Which would mean re-negotiation of the feature bit.

>
>> +		vb->page_reporting_conf.report =3D NULL;
>> +		vb->page_reporting_conf.max_pages =3D 0;
>> +		return;
>> +	}
>> +}
>> +
>>  static void set_page_pfns(struct virtio_balloon *vb,
>>  			  __virtio32 pfns[], struct page *page)
>>  {
>> @@ -476,6 +524,7 @@ static int init_vqs(struct virtio_balloon *vb)
>>  	names[VIRTIO_BALLOON_VQ_DEFLATE] =3D "deflate";
>>  	names[VIRTIO_BALLOON_VQ_STATS] =3D NULL;
>>  	names[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
>> +	names[VIRTIO_BALLOON_VQ_REPORTING] =3D NULL;
>> =20
>>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>>  		names[VIRTIO_BALLOON_VQ_STATS] =3D "stats";
>> @@ -487,11 +536,18 @@ static int init_vqs(struct virtio_balloon *vb)
>>  		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
>>  	}
>> =20
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
>> +		names[VIRTIO_BALLOON_VQ_REPORTING] =3D "reporting_vq";
>> +		callbacks[VIRTIO_BALLOON_VQ_REPORTING] =3D balloon_ack;
> Do we even want to try to set up the reporting queue if reporting has
> been disabled via module parameter? Might make more sense to not even
> negotiate the feature bit in that case.

True.
I think this should be replaced with something like (page_reporting_flag =
&&
virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)).

>
>> +	}
>>  	err =3D vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
>>  					 vqs, callbacks, names, NULL, NULL);
>>  	if (err)
>>  		return err;
>> =20
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
>> +		vb->reporting_vq =3D vqs[VIRTIO_BALLOON_VQ_REPORTING];
>> +
>>  	vb->inflate_vq =3D vqs[VIRTIO_BALLOON_VQ_INFLATE];
>>  	vb->deflate_vq =3D vqs[VIRTIO_BALLOON_VQ_DEFLATE];
>>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>> @@ -924,6 +980,9 @@ static int virtballoon_probe(struct virtio_device =
*vdev)
>>  		if (err)
>>  			goto out_del_balloon_wq;
>>  	}
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
>> +	    page_reporting_flag)
>> +		virtballoon_page_reporting_setup(vb);
> In that case, you'd only need to check for the feature bit here.

Why is that?
I think both the checks should be present here as we need both the condit=
ions to
be true to enable page reporting.
However, the order should be reversed because of the reason you mentioned=
 earlier.

>
>>  	virtio_device_ready(vdev);
>> =20
>>  	if (towards_target(vb))
>> @@ -971,6 +1030,8 @@ static void virtballoon_remove(struct virtio_devi=
ce *vdev)
>>  		destroy_workqueue(vb->balloon_wq);
>>  	}
>> =20
>> +	if (page_reporting_flag)
>> +		page_reporting_disable(&vb->page_reporting_conf);
> I think you should not disable it if the feature bit was never offered
> in the first place, right?

Yes.
I should check both feature bit and module parameter here.

>
>>  	remove_common(vb);
>>  #ifdef CONFIG_BALLOON_COMPACTION
>>  	if (vb->vb_dev_info.inode)
> (...)
--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

