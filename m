Return-Path: <virtio-dev-return-12330-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE04C7618E
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:04:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EFD682A8DE
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:04:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD83598663F
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:04:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9914B98634C; Thu, 20 Apr 2023 20:04:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A786986635;
	Thu, 20 Apr 2023 20:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Heep/Xwi+8RVADq4RG4m/JintjPP5N+0v8G/I/4NeYdX18rbkih3hOxozCEU2sDzzCaILW8fau6n7j2qlLbd18bwJbRUakAjicJeMegl0rbObYdceO1/hiLndf2zWSCQ9JhUhWITrRK44YIMFMMR/svpTgbq5V8P2Tvfn6wvh9Ova28GyfKcZkBrGKSgdZfaEvn0UiB4WT/sUGlxT1cZTEazoK4wxpiobOka2u9HumdW5H/NgBtGAkBeBNjx2VSgnO6VncGaa0fWAGbWSzXj1THu62LOTAhOfR1Yd4x/z2UcIU14apSKyrSToVB1CbfG10UGqP/R8SzWUECVgftbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM5UJUIjHOu+YywUzSyDKKCcoUajpFZMu1yD+5Iy7bI=;
 b=VccVj0Gt2OZGpr6b2pquSyyGhgxxvn21x3UgRh9+HkdgFd94tt2/g/uLZLOtkJUQXwYefZbXU/G8sYh1am42SJbUZ5csgMje+/5ouexxn2kXoXZGX+sNWFLtAnq1MdnyT7ln175nR/qqOj/B7EmWp/Kz6dG4dmgJwKHECdMkIma9d827ji/AQ+5SuxCCGmETLsYxPF29k766VkzuTuMWghgNAjvtRLkYIs1MRbhAgPTpEUkUFIuT2dVOB0WIBaHsE/HOGmqA20vurzllW0QD2yVxCtjFshtGLy8NwGXvwlKws+M5g55YyIL1fTyxbAGCR4t/Rxturt5qRv+4F6FLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH] vimrc: Increase number of characters per line to 80
Thread-Index: AQHZbLnGFrpW1x16SUyv9fCz3xC1hK80q8fQ
Date: Thu, 20 Apr 2023 20:00:59 +0000
Message-ID:
 <PH0PR12MB54810CFF451FDB16EB4A3B11DC639@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230411210804.753924-1-parav@nvidia.com>
In-Reply-To: <20230411210804.753924-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7266:EE_
x-ms-office365-filtering-correlation-id: ea1c1e7e-40fc-404f-389b-08db41d9f654
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EolODE1YI+Tqg2rbDIuKmkGtpIpzjC39WCSPu20ShjHfXRGqIxNGumPMu8CsDtt+AkoeOhSWR4eKUVPcXFodLbFe1A99KRYH/vv+g+Spu/34i6ZcmZrklDGsV1xwfw+fjt0qcJ6C135Dq9GGh6gNpeHAWFKqKv7mdv45b28bYg1mYNZ7jfTXZZPts7V7m8Qx0AgLViYUWysiIJxsMXEMHNHo0P02D8I4Gw5qHi0A9aRc1jyWJ/r2HIKvWHR3kZQmfmhMVSnVq7jqqiw3IEK5HL+c8z7OdW/kTI/7S7UkNHYuJG7+PLdqJoNl4p9IaYaSZMxoSct2VUudq5dPGauImnF1+IJ860jWCcvlft6wTBAMNAWIo8sX57TfMuXToJ1zg1aam+8oxAqGCN80WMBr1DWBcL78HQ3MkW8H5jIizBhEVEA09PGSUFr3S7nKpY40hakrtaXtnVmjPu+9WB07gmWIjqLXGh1XAp/iWfJX7DMZMfF6w09P7yZr2qocOp9wtsCFz22aFs4bULvVRHD0Uk0vXTM7F5sZAp+KeVFtvHX9bO9OoO+RVjCmaiQQpTTEeWqbG7nA5OREClfQpgYtMVkKlVUkKenvNO5iuyCFNEViLv+vrqpbpdyDUTiKECqv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(2906002)(4744005)(478600001)(71200400001)(86362001)(33656002)(6506007)(9686003)(107886003)(7696005)(38070700005)(186003)(55016003)(41300700001)(54906003)(8936002)(8676002)(38100700002)(122000001)(4326008)(66556008)(66446008)(64756008)(76116006)(66476007)(83380400001)(66946007)(110136005)(316002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZaFUyNTw+ptnAC5vSA+zq0l2beU+vWuptDqRyJL6ztgLpJRp5R6UYqVuVCmj?=
 =?us-ascii?Q?pJJfhUX+FG2azWbhVYeMwK5Aer2Xsly5ETK/UaVWEiCN3QRMzE0udnAphzia?=
 =?us-ascii?Q?OWz4ADV87yPCaGQ3s+xNqzRiJVIm40s+aw0XSAx5Q6UQLq/ErlTseBvbWjrF?=
 =?us-ascii?Q?pnt2FiuJzci/DOJA9g+9iK9YCv+UpV4Q2T4z1+C9D6hUHlEDkyq33Wm+yWK2?=
 =?us-ascii?Q?BU2utj6fyhhd09VkwaJvXSoJZTpSWJG715xm87eqU1Vp3oikJCvy9I1GXExK?=
 =?us-ascii?Q?/FBEjL2IsQHDAm3dJenBTedr6r9eofH0ebCBfLWGVeFGSGItp5M1XNjzi3/Z?=
 =?us-ascii?Q?v0liSkZKq+1XOWYuuXFUczz6RVwOEdesOpqQPu16JHuKQMgVuvWlx5Btnfxt?=
 =?us-ascii?Q?s/27hqcRUEzBcLAgS1JQcKB2LZUSG1cEY5dG1N4KFUQMw7sOazvPcip+dsU0?=
 =?us-ascii?Q?rXAhPTxLYaLBRJgc5u+lg1kF6ALFQ+y4aFnXbzQUn6qpXGzgqTwzMXulRsIA?=
 =?us-ascii?Q?/Uj5dp6RJZVUKkZdg/1nr9Z7c/BV4+kvVNAVJlJV2AV9UJFgWXR3h4B5FnF1?=
 =?us-ascii?Q?AjeoEhaG7FSfH6RUTZo8fZUPko+PKBBbwLdPcvrkNqvORwErVaEgMhg1+8g3?=
 =?us-ascii?Q?4piHobb9le3qe4k+l/Vd85Z5z5rZpnL+ey7mo1JDi1GrjAWxg7zO5Eg1SI0P?=
 =?us-ascii?Q?kdLW262iJaDeEJfbg71zUnLF5lk1+EF+kKuFJrNEn8iaCgXR/hz8aQc5L8SJ?=
 =?us-ascii?Q?sdANRxiBzNIsk+7ABvHO4dx0lPyfzPiIfsIUQqnQRwrf6c2qPq2gYryerx/0?=
 =?us-ascii?Q?qdBuhNcy8933wRjhnzhoL6+EN3KakQFu/t9op1NF2KubzXRjSLyQrBS0gaek?=
 =?us-ascii?Q?NQHBHdOzYlGUlomfc+gOThXOtrdBz/4/W1PNkq5HbbUHtqcvno2/rNfm60OO?=
 =?us-ascii?Q?lAo86NPGqnCvxtJho+38IRWualm0By2P7+RYJA3OzmMM+PINUi5jpmIpLMG8?=
 =?us-ascii?Q?O0PWTsk4FIW6q4CeIH0GLj/E0wQ5LFASdFmv6bq79ZkqrHnZ3P+H1ZZ3mCLq?=
 =?us-ascii?Q?U2lOvrqCiZK5KtyE92rTxE7dcQ9SNgC76ofJZgSmf8h8FK4tx6tMIxtB1FA4?=
 =?us-ascii?Q?lGwIc9vTpsBY3hkLvEJk0imjbQ7RlZEP7FHPlXcxQQJH8fdJO1HQeIFa85SR?=
 =?us-ascii?Q?HQpBCzzSHd2ilRPPeaAeJk/yZacWKnpTJg1AnEaHJ/XRS77vum0tHG/Gi2VN?=
 =?us-ascii?Q?bbaIiq9/AcSmhtzm49xc9QOQ/kzSsL+956LLaMzHvQk+MaPlZ7SgyDbQBCde?=
 =?us-ascii?Q?QNJM5yitjD9IPp3mUY4zVQDHRq6M39BrQLcYs5JXoSTPCAptddMNOx048VFM?=
 =?us-ascii?Q?k2/nrHoSKDoOsXlftXLg12RIL6eFcxHbv+XUMvs5bGCfzv8Alc1t4+UXsXS/?=
 =?us-ascii?Q?vauZqQih0NV72JS25Sf//bAKVl0BpMQBgTbt7vVTq+V1djGJOFYrK0Gl/oFT?=
 =?us-ascii?Q?2Aj5qr8uDO9pKLYYEOv2pINSd3L2DWUQ019u8eQOPASVf5WiV+Sr3syxdm69?=
 =?us-ascii?Q?3Lu/q9SskFdBBgCJrGcWM2DuKJdBLAWnnYncwkMfqNAi6e7IwSLIW8hZdT/f?=
 =?us-ascii?Q?dPi55Xoi68EbymKehYOYI6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1c1e7e-40fc-404f-389b-08db41d9f654
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 20:00:59.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hRf53O25CxYZRN3mpP0RhOQ5G9FPudkdbMnfLmbIOAUG/H6AgL+JIzXA/rTmvRwt9FcApWyh4Mj0/L6Xs7rkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
Subject: [virtio-dev] RE: [PATCH] vimrc: Increase number of characters per line to 80


> From: Parav Pandit <parav@nvidia.com>
> Sent: Tuesday, April 11, 2023 5:08 PM
>=20
> Increase number of characters per line to 80 to avoid aggressive short li=
nes.
>=20
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  _vimrc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/_vimrc b/_vimrc
> index 045b3c5..375a043 100644
> --- a/_vimrc
> +++ b/_vimrc
> @@ -2,4 +2,4 @@
>  "following settings (without the " symbol) as last two lines in $HOME/.v=
imrc:
>  "set secure
>  "set exrc
> -set textwidth=3D65
> +set textwidth=3D80
> --
> 2.26.2

Hi Michael,

Can you please take this patch?
The recent patch from David has an aggressive indentation.
Once we increase the limit to 80, it is easier to let the editing tool do t=
he job.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

