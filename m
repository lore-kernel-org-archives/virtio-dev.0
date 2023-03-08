Return-Path: <virtio-dev-return-11552-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B4DC742A7
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:17:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 85D5126A2D
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:17:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79BFE986737
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:17:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6A35F986702; Wed,  8 Mar 2023 21:17:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E3E7986312;
	Wed,  8 Mar 2023 21:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIX8dD3QbuCeIHiMxELEDYKviiJAUEzFfWixMMdmvzI7+voWT0V8743uOYrlTfeaOmJNK8J8PJII8zngOx1H7sljMhEzUgBiuQvWAk0/KpkRFB6kWXsTIk5fGmYKtOYrEbuTNuTaIdO/YL7YN0FFmVlZB2qNycXaJq8tjAl1vWEnDeiVS49B26fhoM/iBINKdU0idEfqG+S/LM00TLmSNss8RxKkjnjy8TGftEuhx1j1RWRPgRRWda7K7J4iPzztLEgXXoUSTzOpdUe8FFkp9zubx8wvWsWb6ckdnc27yD8rXJgrIRMZihRvgY3qhuzmJwgryVVkevymy0myY86c0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIZ4HYmgUGL0B/1dqFkOV8ZnWhHW7lFsCddGAoJNsQI=;
 b=WUuM+4uiOYIc0Hk2jXpogXCnvkklZnnCuGiuiovVrSsJhlYoSmM/hQtkEqOJu7xvI9e33Pu+pzMZQnNAXNo+9CdFoO07I3BM9bSjpT7DIXYmdXTngXG0XgOG7RyIRmP08IBG7rJP7mdRUesJWHFKSyriwzhNaMxiCZ3iO59YrSjVAnzFUYhAXqCrvUOkhvNs7AZ/F04QFUTnZfl84fw0qJF4/RRSD5eFr1RZYjadld3Elrd1XnmtHyvXYJT4JCSnlD1DNgSBBRNFVQAlcW2PpsV/qHgosJWRbsXUA7JASXKmKKaWRsw68o+KKq7U1Hww7nlgz791sn2QajjVFEIHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com"
	<Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH v10 04/10] admin: introduce virtio
 admin virtqueues
Thread-Index:
 AQHZTQegoqm3ZFh/hkOgShx3CSU6867n9EmAgAA5TwCABbTygIAAf1KAgAMFsICAAALmAIAAAD0w
Date: Wed, 8 Mar 2023 21:17:03 +0000
Message-ID:
 <PH0PR12MB5481594528BDC607CB13C42EDCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <027fff1b-8ed7-abc0-2331-b188b8822bf4@nvidia.com>
 <20230306174850-mutt-send-email-mst@kernel.org>
 <e12ab469-4586-f0f5-b084-8f2d7c031e11@nvidia.com>
 <20230308160834-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230308160834-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB5670:EE_
x-ms-office365-filtering-correlation-id: fb62d803-2f40-4c15-363e-08db201a76e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YULoo6QxtQo0bAowJSMfPXx99IgXYpqQrKhzMf0tPC4O7VkKd2AOyqIWIgAxkjprN0y1g0RrL7HgzwQ/igjQBQXyU88zAqs15FXdg758mg0oSxB4tqvhUXGzoFHuRCXRZkeZPQFziWm/iELwBxdqEwHO+bWEfwjZAraxFeLrtAwI3+fT7AtOi7GbJroL4WSN+u1CFdK1JmdtPqp3AFZUv+pgwsX5rz7w3ecin5WAfHTVNIzMOQVIBOx+RIVvnmbQY30DT+XKsrbvLMLo3xPQRAMIVoSMyqe1vAhXCSUDUQbm1gncNZRwlLQnQDaWb4+0saTh+RLpdfNvCd6cwMaP60Nrfh4f8rFpNC/eM29tO3kqsQboGQHOLTFJK018W0c8ladv4m4gBYUds5WrKqMoew4TQS7YpsW/Nikf6+P5PqeRC0lvkDUe+ztHQXd5ljU6U/GQNATLKSw4/mO7Oc9EPGsCVoTWfDb4kV7c9o4HSmoPstKQT9U7wnJLBUgw2AehisbuXCM39xrG09KhW1s8HlXulNMSl37NQ60mobxrUqYcolODuZ+a403LEt9pyFVDMc9SlcMYn1xGJ4pq3pTw1ikecuShnD3uu3HU3wmJWWV+g3KoBAnnIJAbS7llZxGsuDn/S1O3nC2jc50XwVPR156qcbiMgKw3uY3k9oDG7MgWPRQcb7caQ3GyTOvOT579QWks+krJmKTXVXXKlsuSKA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199018)(64756008)(66946007)(6636002)(76116006)(4326008)(66446008)(66556008)(66476007)(83380400001)(186003)(55016003)(38070700005)(38100700002)(122000001)(9686003)(54906003)(110136005)(478600001)(7696005)(6506007)(86362001)(33656002)(316002)(8676002)(71200400001)(2906002)(8936002)(5660300002)(52536014)(7416002)(107886003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gPuhR55aqbx9jJqTkhwxacT09jdbr9iglw5r42dM1bzqJjgBGSaf4fGjvaTn?=
 =?us-ascii?Q?S1IPn4KnPj4KWN7oBxYSOpPwH+8cxC65PcBFNKsnXCyOXIWFs+eErMHDwg8v?=
 =?us-ascii?Q?RW/5sbIJYz8YO7usfy+xntOFYJtCMC+7ifZoMvaMNE8DWb9hzLFNSik5UMcm?=
 =?us-ascii?Q?r9Z64qDNzvWf3Z6c7f+R3Fp9r3+KeyQbomsMJevH+7Hn3WcJDcW/BB6Afab/?=
 =?us-ascii?Q?h+fczEDiY8xI645xAZMs/ft+gPoglIDhmQwwfOUVhrLvJYQyGsqGAOXta64m?=
 =?us-ascii?Q?vAzBy3CuHHuyIWBTeApDh8RbHNnDw550hgKYKuU/TfxbYUGvwPMWToSpRjG/?=
 =?us-ascii?Q?f58NF40ro+zplDdrTWQUp2eFVtZwfqpZv62a+5/H9r3/Ra8oLBYjRCP3z646?=
 =?us-ascii?Q?OwMOUdsY94xWppSFR5l/WGS/RdwCZUa1xmTc34RSJA4GQUifVu0HiSpJobzX?=
 =?us-ascii?Q?oizcnsc+YNIFj3bjsMHmyWIVHcqR9rSnf/uaveqJ8lltYmfjnUm9KKXXttVe?=
 =?us-ascii?Q?ubNQdiVacIRuQFJfcvbPWlocF8QFNPSYTwXdTezVim2hz/FXm2/gSJP6Eeac?=
 =?us-ascii?Q?c7qUoiSWTTZf32znNzYHvqY+8u3R1vx1D3d+vaD/qQ/sxL7je44mH+XOosnc?=
 =?us-ascii?Q?IfLFHANmS5jt0fFr9EIG7dutITIaFQ8PzXcgIuLNKAl+ndSkZeXPhoK0rUhv?=
 =?us-ascii?Q?i6VNiDA91B4rPv8LGqrwNYCD9SOn+A2964ZXYWRMqx1XaKqJ7UCUlPSXZVKe?=
 =?us-ascii?Q?7G5lYf7zmDkDvHBfxR+yP5akOI01Pz+u1jcFTB7mY7uoottODYNAWsfvueCW?=
 =?us-ascii?Q?tG83VKLquBsM7wH555yxaRBgd8tDK7A0Qw6OU213ig/jjg+ojKZxJ0uAYvkA?=
 =?us-ascii?Q?ivRXFcqXR/G+bh+VSaBn7waPZS8GPYCbMeVfPh/j8bGOa4vR1c48uz4UVMgI?=
 =?us-ascii?Q?t+fJBCmSdQ/mku2YJSLKLrdi+MwyaFog1U64/ILZgClu9kT4NdyMsyDqcM2R?=
 =?us-ascii?Q?pXH5y8jUwsA8WB9OBqkmXoTOQI7awF/IgR1YisXNqT3utqqQCyVQErJnQhwF?=
 =?us-ascii?Q?SSBvhELnk3IL8NclZMa0RamDog/98fm22fliy4I6/Hcyl+Wzav1dJeppwV1X?=
 =?us-ascii?Q?Fr96rpXCZiwIdO9yaQ8cufVXisR4CwMNAB5B352qPo5TTNlKj3Q2DUvFZkhe?=
 =?us-ascii?Q?KTMOmBYZrRFpvbdHmWhnk3zkricb+o4toFbcBWnUZiXIhOlScdxi8vxOyiUS?=
 =?us-ascii?Q?zZLjQRZBjdjFb00n8QVGeh9BqppZW2/PKujpn5oSNiWl7+09Nu1K6z3IiuVx?=
 =?us-ascii?Q?HRHSLhcAeHNPDH2CZxFQDzz4shH2ijTskeLke9W8i5MoGT9QXwAKYUtobCc7?=
 =?us-ascii?Q?oLwn+HvXUcDeq9IhPjHRs9JGL3wh2DcLbtUCsZ60k9l46pd3lklLsufa14cn?=
 =?us-ascii?Q?ugSTcLIblEA5YYtHZoCimtOEjvQs/JiOkIIU98wmJscGboYBsOqs4GF903wo?=
 =?us-ascii?Q?E9a0i55kaNfYS8CPPqX+ZXeR8jjeyGz4EtDwGDXL7QGGAmdRv+ndjqSASkW4?=
 =?us-ascii?Q?X7bi9SXEOqGTDuE/T3KKKuknEAZIfGMJoeguMq6iBqaq+KCg1/PWBEZC1Tu/?=
 =?us-ascii?Q?4fsqZ89hOdlYLmVsxxnPZsk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb62d803-2f40-4c15-363e-08db201a76e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 21:17:03.8273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc0/YcErd41gLL34lJgFlwevtk/H5PHgfNexfTewPEHIjRUdUzeUd0q3ed4eTUbuaUK7drBCZBi7SxZid9waRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v10 04/10] admin: introduce virtio
 admin virtqueues


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, March 8, 2023 4:09 PM
>=20
> On Wed, Mar 08, 2023 at 10:58:59PM +0200, Max Gurtovoy wrote:
> > We have a non-spec prototypes for LM so please use our experience in
> > this area.
>=20
> Don't see what the fuss is about.  Nothing will prevent your device from =
using a
> single queue if that is what you want.

I think the use case is not clear in the cover letter on how/when multiple =
aq are useful or will be used.

I agree with you on this single queue should be enough provided a single qu=
eue suffices below design aspects:

The design:
a. to have one aq to support multiple outstanding commands
b. ability to execute unrelated aq commands by device in parallel
c. driver to not issue related commands to the AQ (because they are execute=
d out of order by the device)
(Assumption is IN_ORDER is not negotiated).

Above the actual use case requirements/expectations from the AQ.

The current version indicates that the device will execute commands in-orde=
r, hence multi-queue is needed to achieve parallelism - is not serving the =
purpose of "q" notion fully.
Or do I miss reading v10?



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

