Return-Path: <virtio-dev-return-13916-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B116E706FA
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:17:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AECFB2B01B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:17:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81C6998668A
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:17:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 66AF598667D; Thu, 21 Sep 2023 09:17:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5541B98667E
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 09:17:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV4lX6nNgzGw4/zPm9ayvPar1PyGlX7SQCe/uFU8cBwBBQiJLz+sAczSADfWt7MZz487ZmqbMtspR6+w88wDsNuuratf1SArmmkrLlVem+mCDJmdg1ALB6cB3kyo03Pi6IHARlO2ppa7r4VifTThiNf7EupxyGr+C4b2h/LUMK+Vnn6mNXEHKGkmwriQWNOB1e8drv51jrEO2hFgwt6i/xsKXBTnEpehFKMl5JiDq8C3zUi+obEl+4b31RlM0XlYK/2bK4LxeYoXJKnJoe+sUY759NvVZMjF0xlgrQzhsVCf4CdCa8OiCon488S3FhVI2kqhLIWoXXfdXX3nwTQjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZbeCJbifd3F3l4OQ/fFQ+EcPRU+Uz4uhwgUGsAXc1A=;
 b=BM9AU4TdqxBCTGk8xh8z/2y2lGVoDBEcvUJIvnP21mojnfln4oil68rJrthf/L9T/Fv4D9AOPARSuioLUt5moBh5qfpdeB5i/ZSj0gNwo8GajCXQJ5KduJXeBjpXVTS+Pn60P0tN4BO/y/3hcLrD8zRi34CunBJNXgLYPdx7XYtN56NPAjJ0QBxK3NWsfp2ET6yHpReWsO8iEsN7dZw+kc0H1ky0J6lbIBNMUTq/njHgOKxVOopcc3wBH4dpXv/5leciW0fFNk4w56uJHYcZBNE8r2VTGi6YnXvyCqllItXU5HisWVVXSPzVVNYpwwzeAyGpGK9OuPrEQbwRylTNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAABiEAIAAJySAgAA6DQCAAH/8EIAAIYaAgAAAnQCAAAZZAIAAAKfwgAAT/YCAAADbUIAADTWAgAAEM0A=
Date: Thu, 21 Sep 2023 09:17:53 +0000
Message-ID:
 <PH0PR12MB5481F59CBD9B2B615D6F4B0EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921040133-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921040133-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB5483:EE_
x-ms-office365-filtering-correlation-id: 4ae1bde3-5031-45d1-7c2d-08dbba83a2c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iEfEwqivYmq0f1JTUKyezsPbQ5jBcXDQNCWZDSmjuIt05zJ8TtinxxRf/w4LOGteNvf6aXF95GyTme++bY1KJR6a5jMKgV6AazmR6swvP6y6YPuUu3QkYuw7ukLlSziV+GeK+Jtm0CC8eHlpSJy5KbBz1rHAQTvDoIUTf/zzrGv/j8s4rt8rAa7Jb9zSas3nyFR/2+1bCm5uDUx9yMn0ANGJCpy8GhT+WDK7otLm2y2MCE1AEEyHBlot6bi1fS204BSWOD9O9LvvlIDziGB8XNdGSC0PXpYzYyF/Qo3iEZCQJNIHLU61AWkfBVnfngVoCiglasOJXwmFYZXdMkkCY/FFLBQCTg8PsbHNJjfprr7NGRJ7ABz96QJDDzo1FwwrKdJckO4GPto0xdjSdWw0Rt36/Y9/GmwCPOetrcYPkNgMjheixlbnkXIIr0OBW76lkHmVi5PR04/bpGLhTv3tpYVfMRKfpg+LEXEu7BxwCj2b4tMvxBFr0JVgPPpjpA4XS7r3Fc8T7hPrBcOo1y+L/MMbrnQv+/8xxLo3CbzXzz+CMQKIVG03tULaSvXtmNpOgJ0oX8ygrvk5EWqXT25Y6FcDfAvsBAXZdQhDnKUOvdopy9lYSK/0//wOytB08NLj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199024)(186009)(1800799009)(52536014)(5660300002)(2906002)(15650500001)(4326008)(38070700005)(38100700002)(41300700001)(8936002)(8676002)(316002)(66946007)(76116006)(66446008)(66476007)(66556008)(54906003)(6916009)(64756008)(33656002)(86362001)(55016003)(26005)(83380400001)(9686003)(71200400001)(6506007)(7696005)(55236004)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C0AQ5K0qeFC5e2cK+W39r5raECNFy2Hul5byWZO4Upw6LlJjIgLJ12m0VpHc?=
 =?us-ascii?Q?JIFV2JFJb/C4TALL5HrnHMjSIdZ6FSWofNSbnhf8oL62bvlGYD6+BAq1xEsQ?=
 =?us-ascii?Q?WIqxx+NAXzGb9LpiwSTd8iqjXim1dW5vqq1DcEPZHr3e5rQO6SOL40IwuHbC?=
 =?us-ascii?Q?2WXIPSjzyoETpexJGCjMfITVrs2q7q0ssAr/J672qh/5R93KoteiHdfer+6p?=
 =?us-ascii?Q?iY+UO5mIjEvdBfrlPCZd9r7XgBxS4rdSVZMrW+C7onvv1et0JwmNPu9SiksB?=
 =?us-ascii?Q?LqEFRY30EAWOcWvxxdNsE+mWq8r+ixBmCwRynqT1vO7rmyNVuBuvyGgxmHLc?=
 =?us-ascii?Q?/T5kyxNOSJGZJRCYUh5qWhi5df0NHuhSdP7Mnc8ov8GTPDJMhqZJDdyV70E/?=
 =?us-ascii?Q?F6GeuACmWuO9VjFri2rKa4EsyihYidJqABwiDyhm//mL6N4qGZRCEfKUzDsR?=
 =?us-ascii?Q?G+8peVt2W/lnbZNh/R6Uhxs0T5ssaNxFioB5N7F5iqDSk+NTQWy8sPTGccg+?=
 =?us-ascii?Q?Ld2FDnXe254cpDOz0PzuBxNtkfr2TZKq6wWNxMSLfmziw2jvsogmj7Qa8yUU?=
 =?us-ascii?Q?si5aVcH62f8FaUCCsQLL58NGqp78z+mMI5nCyXjlN9tEBdGiGssMppqBUFKp?=
 =?us-ascii?Q?phoiDGAah+7issJItUzzVtUwo3sONiE8rR5t/WQdK9uqnSQjY/1at88BKTyM?=
 =?us-ascii?Q?yngDRfAlxkKXyMS0aRC8gxsNO6kX1Kw6Ut+MoFSuCOUqCNhpnWr1UFD7JTAb?=
 =?us-ascii?Q?7/0WwdbSWVxB9sbbm61b4s+q45ZM+zen/GRhEOLQU6JqqnVfiAQKq99/WLs9?=
 =?us-ascii?Q?x1XG/7TR0AJSDYXI+2sJ+eTyk7y+G2Wp1vA/Hjc2koQoD9KIAW34amMLxxPX?=
 =?us-ascii?Q?nHndM8Grpl7Z3MRgsBmzqAsjdVEtL5ugtirusLLt8QdviWJJar2XgbeGtadV?=
 =?us-ascii?Q?9zCXL0gPCwdlqsw5ZYosorERO1JwENmceXTK2j6kyBstW85/f7+Zokv4fwL9?=
 =?us-ascii?Q?3vUgKJinU4pIYAYLtxCwdR8XaxQCSfv/JF/qcF0/HGVfh/PWLemL3RJZq0hz?=
 =?us-ascii?Q?M38ksYt0h28QTDimOylBKUjImMs7RsCWKMqy6URd5FVHfhrg/UGEnFhaYUt4?=
 =?us-ascii?Q?ofYs7ob8rwJrsAZjKkhIJBIuGarXfT0s1fjBCi1kZV6N1jWQ3cz1H5+WH1F1?=
 =?us-ascii?Q?pXp6D0sy3qWhclrjdqa5ze9TK2NNM2Je/yHhzK2VZwSv7DAeCzvAKG02rMcq?=
 =?us-ascii?Q?e9zqURXIYBY6I1x9l21NbffrngfVHGi0jwWPuIvELSt4TQcuX8iLSjhTZSX8?=
 =?us-ascii?Q?b3/CiQfcG6zlzAV5BS9aPu5aBnJ1F9cRhjUaO/AmysA0SVEu1g9PvmbNZqVb?=
 =?us-ascii?Q?fjD1wgpKb6FfL77KrT7Kx/F9NS+8J7esnsGONU3Tx7v039AfU8+Ej+8yfbnU?=
 =?us-ascii?Q?tm1prwcQrhsNWzyjXR61+3ii/7dTLi3JQ+HGWWw2oBKfCcxKBmI64lO+XHac?=
 =?us-ascii?Q?r4JwPV6udfMZsDNh69kfYmOcz5OvPUeU/SxMt1l8SYmXziWWN5gUlsK5MktS?=
 =?us-ascii?Q?MblGguyRIThDh4glTIM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae1bde3-5031-45d1-7c2d-08dbba83a2c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:17:53.7279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RX96WtkA9Ez7NaaeJpeE770lW3xZqKBREv1Xdeh/0NLHRl82DfLWFaM2qDNeG+Y46AjOJ/Od+Lk7oMykmRqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, September 21, 2023 1:41 PM

> > I mean to say,
> > Virtio spec has not achieved mediation less, device migration.
> > Virtio spec has not achieved device migration using mediation.
>=20
> But yes it has - it was implemented with shadow vq.
>
Shadow vq + several other trap points on config space, cvq and more.

we cannot suspend the whole device and resume from where it was left off.
Those extensions are happening now.

> > And two proposals are trying to do it.
> >
> > >
> > > > >
> > > > > > > 1. For mediation something that works within existing
> > > > > > > mediation framework - e.g. reusing as he does feature bits -
> > > > > > > will require less support than a completely separate facility=
.
> > > > > > > I think Zhu Lingshan also believes that since there will be
> > > > > > > less code -> less security issues.
> > > > > > >
> > > > > > With approach of [1], there is less code in the core device
> > > > > > migration flow
> > > > > because none of those fields etc are parsed/read/written by the
> > > > > driver software.
> > > > >
> > > > > What is or is not executed in a specific flow is a separate quest=
ion.
> > > > > But the point is vdpa and any mediation have to talk virtio
> > > > > things such as feature bits. So reusing e.g. feature bits needs
> > > > > less code than operating the admin command machinery to check
> > > > > what is supported. Yes, you can operate this machinery during
> > > > > setup and not during migration itself. It's still less code to ma=
intain.
> > > > >
> > > > I wouldn't go down the path of code comparison.
> > > > But if you want to: we can take a concrete example of what is done
> > > > by similar
> > > device who uses admin command approach.
> > > > The admin command-based approach migration driver is likely 10x
> > > > smaller
> > > than the actual driver driving the feature bits and rest of the confi=
g.
> > >
> > > yes but mediation driver already has to do feature bits. so if doing
> > > mediation then the cost of adding this specific extension is low.
> > >
> > I thought first you were counting the cost of the code and not the spec=
 in your
> point "feature bits needs less code than operating".
>=20
> yes - with vdpa it's mostly just
> 	vdev->status |=3D SUSPEND
> 	vdev->status &=3D ~SUSPEND
> all over the place.
>=20
+ inflight descriptors.

> > > > If one needs more precise numbers of number of lines of code, I can
> derive it.
> > > > As features and functionality grows, every line of code gets added
> > > > there in
> > > mediation too.
> > > > I agree such mediation has value and use case, as we know it is
> > > > not the only
> > > approach fitting all use cases.
> > >
> > > Do you see how this extension is easier for mediation than driving
> > > admin queue though?
> > >
> > If we count the total cost of code than building the mediation framewor=
k +
> extensions, than it is not.
> > But as I said, I wouldn't compare two solutions as they are addressing =
a slightly
> different requirement.
>=20
> yes they are. the point of comparison was explaining why people who use
> mediation anyway might not want to also use aq. can i assume that's clear=
?
>
I am not fully sure.
I frankly don't find it right for member virtio device itself to be mediate=
d.
Vdpa stack make total sense when the underlying device is not virtio and he=
nce emulation.
But when there is native virtio member device, further mediation is overkil=
l for certain scenarios.
But I understand that it helps to utilize a vdpa stack and thereby overcome=
 some limitations, while it introduces other limitations...

> > What to compare is what can be reused between two solutions.
> >
> > > > >
> > > > > > > 2. With or without mediation, the mapping of commands to VFs
> > > > > > > is simpler, allowing more control - for example, let's say
> > > > > > > you want to reset a VF - you do not need to flush the queue
> > > > > > > of existing commands, which might potentially take a long
> > > > > > > time because some other VFs are very busy - you just reset
> > > > > > > the VF which any unmap flow will
> > > > > already do.
> > > > > > >
> > > > > > If I understand you right, to reset a VF, no need to flush the
> > > > > > queues without
> > > > > mediation too.
> > > > > > Just do VF FLR or do device reset, both will be fine.
> > > > >
> > > > > Not to reset the VF - that's a narrow definition. To put it back
> > > > > in its original state unrelated to any VMs.  Nope, FLR is not
> > > > > enough - there could be commands in queue addressing the VF. If
> > > > > they take effect after FLR VF state changed and it can't be
> > > > > cleanly assigned to a new
> > > VM.
> > > > >
> > > > If you mean the SR-PCIM command, than it is virtio spec to define t=
hem.
> > > > We ratified this recently in the PCI-SIG of what gets cleared on
> > > > VF FLR and
> > > what stays that SR-PCIM interface to do.
> > >
> > > Interesting. Which ECN exactly do you refer to?
> > >
> > B405.
> >
> > > > So if other commands are in pipe, only after they are done, such
> > > > VF will be
> > > assigned to new VM.
> > >
> > > Exactly. this is exactly what I meant when I said "flush the queue"
> > > - you have to wait until these commands are done, then do reset.
> > >
> > Not exactly. VF reset is fully controlled by the guest.
> > Hence, it does not collide with admin side of commands,
>=20
> No, host does VF reset in a number of situations, including guest restart=
, guest
> shutdown, etc.
>=20
That is fine, it can do.

> > Same admin command for dirty page tracking and device context do not me=
ss
> with FLR.
> > This is the critical because VF FLR cannot clear the page addresses alr=
eady
> reported and not yet read by the driver.
> > It is covered in admin proposal.
>=20
> They might not mess with it in that you can still do FLR but they will me=
ss with
> what hosts commonly try to achieve with FLR which is getting a clean VF t=
hat
> has nothing to do with a given guest state.
> For example
> - queue stop command on PF
> - flr on VF
> - stop command is seen by PF
>
This just fine, because FLR is not resetting what PF has done.
PF is not touching FLR side of things either.
=20
> will get you a VF that is not running and can not be given to another gue=
st. You
> have to
> - queue stop command on PF
> - stop command is seen by PF
> - flr on VF
> in this order.
>=20
Since you are discussing the admin patches of [1], better to discuss there.
But even if we follow the sequence you described, it is also fine.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

