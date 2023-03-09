Return-Path: <virtio-dev-return-11582-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E0AC64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:54:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 98BDD77EE
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:54:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D08D98671E
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:54:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7FC5298670E; Thu,  9 Mar 2023 16:54:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 692BF9866FB;
	Thu,  9 Mar 2023 16:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg6eLALXp8GLkogttswSEEqmK4Vp7mk9e5apWKon1MdO3gi9KOgQXbCj9W+xGEIjSDNUOjH9W0yMYxEwTlKQCNEoZd/nh6GcmBY/p8D0yKePpBkAm5TyoSSZ6IO5SFhr6NmC4GHAQN2PBch9/SAQ+JPuIM5a1SL2+SAXyewhhtx8wDHuo1CHGC8bde78a+KFjdJfSPBhmJuvQeG9Ws8o/lCSUyB6NCXhVg1qLaSlLHLQIg7NryejkFBuKE1nIsGDXNU0IptG2dA9x1VerAaj2eILPbvO3evdrpwPLKfKvaqBkDssGK1eo330TvjPOH/ax/NbR0d+NIkLEe/8iETFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ3pHWckl5ZlHCzb+fIdYVuOgvDe+6//7Jl+Zaz344s=;
 b=BZXgLT+nWp2+p+l+WlP0lRgaGIx7TOMP+HrvDOYugaC6UuxKi34KSCgCjkkE+vEb23HZG8zQ+x39d0IjBkobERAAsF20WO9IHf7jIvANDGhzNsieg+i/L6ZrtZOPisuyMQSHqTiLw5xh7mOzymfDDk0iAGQIKm9Mxw486rloMatHEoCt8Nb2rnwZF7Ss9No7B72Yy4370TYbiCojBlRth2vI8xeFDIF1SBFmiik8JlFQJdJU/jSzRwpZDFYXUX2kIWb8UaNWumdsqJtXAMKki7UpnB5YDYgy31Wu7tR6+v+TNlqPnFJrz8FogEpUQ4hJgc6h6I0tNuXgdlkHETwwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: David Edmondson <david.edmondson@oracle.com>, Jiri Pirko
	<jiri@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues
Thread-Index:
 AQHZUaV1hq+swD5r7EeFCHM9rP6wha7wxScAgAAFDACAAFmxgIAACLQAgAA3RYCAAKrygIAAXFnAgAARIACAAACcoIAABP0AgAABAECAAATHgIAAFyMw
Date: Thu, 9 Mar 2023 16:53:59 +0000
Message-ID:
 <PH0PR12MB548118B78312924C00EF14D8DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com> <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmLIc97Ud09YfGT@nanopsycho>
 <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <m2mt4mxbt5.fsf@oracle.com>
 <PH0PR12MB5481FD2D2365CC08A5CD1E64DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230309091904-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548138694D606CE68B9E0C3ADCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230309094240-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230309094240-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW3PR12MB4347:EE_
x-ms-office365-filtering-correlation-id: eee4ac8d-ef82-4910-9ebc-08db20bee0f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vqBUojsYypWR9elUOHXwJC09ccOApSWJF10Oe6HJxbWnzuC2cPYkRksbSUew7L+cJVsnfSg7k2K6N2JaAJyhvxRI9bznfwiRDMsOKbCJ00En0Jv/xLl04tdxXr74ReSxyBbkXiIud9ljRsy+RhsiBiY1zULh9BEhgKE63mnpC9zECYoVLmAr41cnCG0Flxfo5B6NX+ii3MrZ7BJ78wn14y282rkVu/XlEePdsb5KDls6sI9RNqqZIB08YtTV8GoZLJRIqOSO8bJZ1UX0kuXeAh5YLaOWmN6cA6BtdDIMtPE/lxg25svylMXD2b4fQTSR8OGr6jrruMtkVYJ1t9OtgjZG+tu5GntgPxlhd5ATKz1SmnY8ewYVpWa6AeQAgLN7n4cacms2OmAWohtui+seRQ2/bFtbTUqFY2niPUtO9zB9uxzQkMwtkS/1Larc41kzCqSfdFGeRh4zdJqPt6LjePqMvNfteDC/909YfKr+6AbwbEoU1pZO+VtWTOEh+wNVomL1KMmCms0Cs5AqsIQu2FCBz4krjzpBNWeh2j0nDW+jWWnnbNg2P5sJiNL1Rkrv9ufuskeI8Yzp3RX/ycBNPh6DjxPFY1gYnqsrWmFUQyc1sAoEfPEmsbXIKXojYxkldm0JT2W83g/ukebzziscjiDvpQjHd3+sGSVI5oqComuuISLTgCKdgqBpSshZaBJWLc22PRg1sbW21CQ1U6reHw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199018)(33656002)(83380400001)(71200400001)(9686003)(186003)(6506007)(7696005)(5660300002)(107886003)(6916009)(41300700001)(8936002)(64756008)(66556008)(7416002)(66946007)(66446008)(86362001)(76116006)(2906002)(8676002)(66476007)(4326008)(52536014)(38070700005)(122000001)(316002)(38100700002)(478600001)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hy/4ibfyr+KQYzzpda2Q/aPVxRnROCFWIQt0pwmOcPLeW+3J77lknBMQMYAk?=
 =?us-ascii?Q?2gQes6VPdAVWYmglNKioYX7uc6PkhoKY2aKmPfwNmU97Sg0t0nMSibFjKjwZ?=
 =?us-ascii?Q?z9YamFY3reL6kbR9vpSoTRrH8yQ8MZeR3iVOSN2uUryUBMqo8j/hjdHuj7VL?=
 =?us-ascii?Q?BFBpJgw9ieuyrxdHQEJa1dPMWmAlw3pVZt0DZwkn0MRyHpuk8emO8NC4A/a6?=
 =?us-ascii?Q?YN0bFgbUv1VQoE9tijA03Xmu6kFcx8iFIfbX9giJBgNfMYyErYap2Ox4VUDs?=
 =?us-ascii?Q?kWhk/97X5Ig6AUX5yDO36Z0M7b2dD4ePbZ/eemAW75SgwtCMocb2wX6DcEPA?=
 =?us-ascii?Q?oNdfsBkkDm7hdxDggvbsIWFF5I4HvTF6qN9ZN2ywCen1ZmFse65AflnWIl/w?=
 =?us-ascii?Q?ctMNHNqC5O+8eeAPKycHYdzwmlbPmVMmHZeS6VfHbtjqUTaj9S5hhGY51VdV?=
 =?us-ascii?Q?+IEFUY6SqNbX9PIBpMaq8iPZruewTtrX0tN67kzJqWX6OWKDv23fFMb3hXT5?=
 =?us-ascii?Q?udpRAJt8UHc/MSVx/i1SHwibQg+/7OTWyXmaG/TMFL764lBC4qwePfkJZwX/?=
 =?us-ascii?Q?cuJiA4iPDh4RsY5/Csd1dbAoeykl+0kgJDzO6P8+lq+C0htUVeTbYwZBDT8o?=
 =?us-ascii?Q?huODs6dQDUFzYwM8gJ+VnDCgAxof2XRYhm+XxMmW11EhhLJ7pTVlQsh83ulG?=
 =?us-ascii?Q?zfKEjOWtYpiFQ3Zh0kGT6nsOV71celvMH8goIBo6j1a/QZ5re5aLNOCmpepR?=
 =?us-ascii?Q?BNsWzYBy/s3cWNfEpLjNwcef2TXAQPyWlc6PiyS7DoYjIN6xE+EmDWLsD4+J?=
 =?us-ascii?Q?8hTPZwt88EgzOnYXEOA4itIlrU1nV/hUkBnODDRYSynHvY+a9OUly2Wmyw+W?=
 =?us-ascii?Q?pqzZyxAEXdATSJ/5oBorsveBijsaVsC5PYodOIFUFlP/phc5RK02qK/5T7/x?=
 =?us-ascii?Q?B76Tve0UeGq9RKwm+feQGwaLR/AP4hIZ+kmrTnIjlZOPjkojwpf0ap6TGGd1?=
 =?us-ascii?Q?q4233GethPMKEYvpy+AGupy2GpF75Zol86inmMveDD+EXqECljTCWg94D/8J?=
 =?us-ascii?Q?R0P+DYAGCIGWaJdzdtYoKJSijW0SWba9180dMDo2c5W6rd4mMT9FW1JXk2Ll?=
 =?us-ascii?Q?taDZsSwcRKBkYyo9FeNrObDDbluASrvZ8bcOKgTZc9WwMMZbbFRAkvK5SZe2?=
 =?us-ascii?Q?wMfWFHHEB9sd/OPAC2tSyT0KSZ+4+k0CGLNBifOF9pFdsSSipKFHJl6U9HtM?=
 =?us-ascii?Q?ECQDrg5SJ/Zu0mDdjzjcTq7J/E2xD2Ky6L4SQN4DcVd9yCI/EQxE56SEz7VN?=
 =?us-ascii?Q?QXjqU5ZaUIRtkJQXdOfwlsLYUL0bySqyVxg+h1A55gkmlFTITrVKWOsOEu2j?=
 =?us-ascii?Q?eP2R1o2HoTWoFVBbVG2NjjAICaRfkqP1IHvAT2NAlX1rECNtbue67jocgjEj?=
 =?us-ascii?Q?ZikntNDoMurdw0hKcjrPTHMyvvYWC8x5vH7yG+ctRBSKhSpU27XFlqX+hoTH?=
 =?us-ascii?Q?THYTp0eHO5nYOBkfZq2GP91STx0ffklVGku7Dk678sIrdy7sXvu0BFwG9Q84?=
 =?us-ascii?Q?mnfIOk525tlU6bchvjOVm8jBm/LnxkQQxK1T+spMhzfbKrTF9HHdsc+4ZsB/?=
 =?us-ascii?Q?RouJJsXPMbrI/zccfeam28M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee4ac8d-ef82-4910-9ebc-08db20bee0f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 16:53:59.2525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRlMLsp8Zm3VvdQ8LFfdicdtl8y3p5FxRQj2xch8PPO/wFQC+7QjaNL3dCIkgPODkrs1r1/Mx17F08tq3KzfQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 9, 2023 9:43 AM

> > >
> > Ok. so there may be some use case for transport VQ.
> > Worth to mention in the cover letter and things will be fine.
> > Actual review of the transport VQ and its use will be in the respective
> patchset.
> >
> > > > 2. Having the infrastructure to support multiple AQ is also good.
> > > > The extra cost of this infra is only one read-only field =3D aq
> > > > count as Michael
> > > proposed.
> > > >
> > > > 3. Ability to send multiple outstanding commands and execute them
> > > > out of
> > > order by device is/should be supported as long as IN_ORDER is not
> negotiated.
> > > > Should it be relaxed for AQ that even if IN_ORDER is negotiated,
> > > > AQ by
> > > default can be out of order queue?
> > >
> > > I feel there's no need: driver can just avoid negotiating IN_ORDER.
> > I didn't understand the "no need" part.
> > Do you mean to make use of out-of-order AQ commands, driver should skip
> IN_ORDER negotiation for the data path queues?
> > If yes, it may not be a big loss for the PF.
> >
> > I am considering that since AQ is so fresh, it can keep itself detached=
 from
> the IN_ORDER from the beginning.
> > This way AQ and data path queues stay on their own course.
>=20
> You can make this claim for different types of data queues too.
Those queues are already defined. Without any new feature bit, not sure how=
 can it change.

> I'd rather try to solve it for all queues than special-case AQ.
>=20
AQ is newly introduce which has chance of not follow the same limitations a=
s existing queues.

Keeping my inputs aside for moment, what do you propose for v11?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

