Return-Path: <virtio-dev-return-11346-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87EEC64ED6
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 16:38:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 05FF42AD5F
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 16:38:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DDBEE986679
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 16:38:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C4EDA98666C; Wed,  1 Mar 2023 16:38:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B317B98666D
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Mar 2023 16:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MLJB0AywjKErpano3hVxQBKZ1gllESkhAW0hnMNDsWQ=;
        b=rztA122ob3J4oqzFycid+OFimI5rFbItaE1g9RrvjtJUk2vppEdbpKq+oiGKWgRPPQ
         bjVz34ANowb50En4VPxncys5dN9tEZbP5HC7FDlNLBzG0M6CCa43kYuPjFECIRAkZ+p3
         gU4gXpQEZKyiV0z6SapXQkf/Z3VMfBfz1fNCQoWHoy1WXHRKrlCGrhMlrMS7rpdcE2tw
         AfDp/y4g2CSJSbvgAh1gGfJETZ6feTPai2UDpVi+p9vv4ALrEOSx0AEMVO5EBoY4P4bY
         Lm0PsjtfaqZ5D7viKrE8kS3innX89beTJ5kvJW0ETYvxihJGZOOxhemCHLDxmNkrBKfT
         oYZw==
X-Gm-Message-State: AO0yUKVE8NqLvjoImNfk1ShEfOoNu+aW1CH99NiPOm/6iLnVIrHkIt30
	7NVYhq7fnsxOfOq88Kb/oA5Bbw==
X-Google-Smtp-Source: AK7set8WBgfC36G3IFqFpRa7gBd2pVVtyWUHN64EG9LFoiuEgjP0tf5cL7IIFNkQ8zEijLa0yqq7mg==
X-Received: by 2002:a05:600c:44d4:b0:3eb:29fe:7baa with SMTP id f20-20020a05600c44d400b003eb29fe7baamr5520403wmo.34.1677688721652;
        Wed, 01 Mar 2023 08:38:41 -0800 (PST)
References: <Y/9zkDAS4odz93GM@fedora>
User-agent: mu4e 1.9.21; emacs 29.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, qemu-devel@nongnu.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, stratos-dev@op-lists.linaro.org, Oleksandr
 Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org, Andrew Cooper
 <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>, Sebastien
 Boeuf <sebastien.boeuf@intel.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 virtio-dev@lists.oasis-open.org
Date: Wed, 01 Mar 2023 16:31:41 +0000
In-reply-to: <Y/9zkDAS4odz93GM@fedora>
Message-ID: <877cw0ctpr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [RFC QEMU] docs: vhost-user: Add custom memory
 mapping support


Stefan Hajnoczi <stefanha@redhat.com> writes:

> [[PGP Signed Part:Undecided]]
> Resend - for some reason my email didn't make it out.
>
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Subject: Re: [virtio-dev] [RFC QEMU] docs: vhost-user: Add custom memory
>  mapping support
> To: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, "Michael S.
>  Tsirkin" <mst@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
>  Alex Benn=C3=A9e <alex.bennee@linaro.org>,
> 	stratos-dev@op-lists.linaro.org, Oleksandr Tyshchenko
>  <olekstysh@gmail.com>, xen-devel@lists.xen.org, Andrew Cooper
>  <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>, Sebastien
>  Boeuf
> 	<sebastien.boeuf@intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Mathieu
>  Poirier <mathieu.poirier@linaro.org>
> Date: Tue, 21 Feb 2023 10:17:01 -0500 (1 week, 1 day, 1 hour ago)
> Flags: seen, signed, personal
>
> On Tue, Feb 21, 2023 at 03:20:41PM +0530, Viresh Kumar wrote:
>> The current model of memory mapping at the back-end works fine with
>> Qemu, where a standard call to mmap() for the respective file
>> descriptor, passed from front-end, is generally all we need to do before
>> the front-end can start accessing the guest memory.
>>=20
>> There are other complex cases though, where we need more information at
>> the backend and need to do more than just an mmap() call. For example,
>> Xen, a type-1 hypervisor, currently supports memory mapping via two
>> different methods, foreign-mapping (via /dev/privcmd) and grant-dev (via
>> /dev/gntdev). In both these cases, the back-end needs to call mmap()
>> followed by an ioctl() (or vice-versa), and need to pass extra
>> information via the ioctl(), like the Xen domain-id of the guest whose
>> memory we are trying to map.
>>=20
>> Add a new protocol feature, 'VHOST_USER_PROTOCOL_F_CUSTOM_MMAP', which
>> lets the back-end know about the additional memory mapping requirements.
>> When this feature is negotiated, the front-end can send the
>> 'VHOST_USER_CUSTOM_MMAP' message type to provide the additional
>> information to the back-end.
>>=20
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  docs/interop/vhost-user.rst | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>
> The alternative to an in-band approach is to configure these details
> out-of-band. For example, via command-line options to the vhost-user
> back-end:
>
>   $ my-xen-device --mapping-type=3Dforeign-mapping --domain-id=3D123
>
> I was thinking about both approaches and don't see an obvious reason to
> choose one or the other. What do you think?

In-band has the nice property of being dynamic and not having to have
some other thing construct command lines. We are also trying to keep the
daemons from being Xen specific and keep the type of mmap as an
implementation detail that is mostly elided by the rust-vmm memory
traits.

>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 3f18ab424eb0..f2b1d705593a 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -258,6 +258,23 @@ Inflight description
>>=20=20
>>  :queue size: a 16-bit size of virtqueues
>>=20=20
>> +Custom mmap description
>> +^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> ++-------+-------+
>> +| flags | value |
>> ++-------+-------+
>> +
>> +:flags: 64-bit bit field
>> +
>> +- Bit 0 is Xen foreign memory access flag - needs Xen foreign memory ma=
pping.
>> +- Bit 1 is Xen grant memory access flag - needs Xen grant memory mappin=
g.
>> +
>> +:value: a 64-bit hypervisor specific value.
>> +
>> +- For Xen foreign or grant memory access, this is set with guest's xen =
domain
>> +  id.
>
> This is highly Xen-specific. How about naming the feature XEN_MMAP
> instead of CUSTOM_MMAP? If someone needs to add other mmap data later,
> they should define their own struct instead of trying to squeeze into
> the same fields as Xen.

We hope to support additional mmap mechanisms in the future - one
proposal is to use the hypervisor specific interface to support an
ioctl() that creates a domain specific device which can then be treated
more generically.

Could we not declare the message as flag + n bytes of domain specific
message as defined my msglen?

> There is an assumption in this design that a single
> VHOST_USER_CUSTOM_MMAP message provides the information necessary for
> all mmaps. Are you sure the limitation that every mmap belongs to the
> same domain will be workable in the future?

Like a daemon servicing multiple VMs? Won't those still be separate
vhost-user control channels though?

>
>> +
>>  C structure
>>  -----------
>>=20=20
>> @@ -867,6 +884,7 @@ Protocol features
>>    #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
>>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>> +  #define VHOST_USER_PROTOCOL_F_CUSTOM_MMAP          17
>>=20=20
>>  Front-end message types
>>  -----------------------
>> @@ -1422,6 +1440,20 @@ Front-end message types
>>    query the back-end for its device status as defined in the Virtio
>>    specification.
>>=20=20
>> +``VHOST_USER_CUSTOM_MMAP``
>
> Most vhost-user protocol messages have a verb like
> get/set/close/add/listen/etc. I suggest renaming this to
> VHOST_USER_SET_XEN_MMAP_INFO.

VHOST_USER_CONFIG_MMAP_QUIRKS?

VHOST_USER_CONFIG_MMAP_TYPE?

>
>> +  :id: 41
>> +  :equivalent ioctl: N/A
>> +  :request payload: Custom mmap description
>> +  :reply payload: N/A
>> +
>> +  When the ``VHOST_USER_PROTOCOL_F_CUSTOM_MMAP`` protocol feature has b=
een
>> +  successfully negotiated, this message is submitted by the front-end to
>> +  notify the back-end of the special memory mapping requirements, that =
the
>> +  back-end needs to take care of, while mapping any memory regions sent
>> +  over by the front-end. The front-end must send this message before
>> +  any memory-regions are sent to the back-end via ``VHOST_USER_SET_MEM_=
TABLE``
>> +  or ``VHOST_USER_ADD_MEM_REG`` message types.
>> +
>>=20=20
>>  Back-end message types
>>  ----------------------
>> --=20
>> 2.31.1.272.g89b43f80a514
>>=20
>>=20
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>=20
>
>
>
> ----------
>
> [[End of PGP Signed Part]]


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

