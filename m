Return-Path: <virtio-dev-return-11387-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B29C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:40:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5C348370EC
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:40:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 553B99866AF
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:40:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4A3899866A2; Thu,  2 Mar 2023 18:40:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 385C698669D;
	Thu,  2 Mar 2023 18:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkCQGicLPBNvCffCqqGA5YVewyTFpVBNhtElOkOOw/wKcCLpy0gQMQWCHxyxnWB9ACVjE/ZdG7HwSNZ5EyrO8f9tRxlIr5Sm3DgiKusMP0S5l0NiSYxDZGO+ltFbwhapqmU7V1K7JdQZ52gW5IPKBEz55GJhDOcja3cjNa38vovcDzcXiFzyn8sLy/vgnLYPsG7chk3fw5jBmcXj/Y7r6ua5c8UnfiQndrYIo4UDVJpijWo26eb3SqPezHm4MF/TEJQA+KREunxHaRfcWaVobFHZ7StuQuRa8wtRdzXxLcUjbMIpMADROR7uEbffAQe1iOmpdp4xMj+I/at3ulDQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVoZSxw84ap4R3y1Opqj7alFbz+We1do+UPhw0opiA8=;
 b=LOfMTeBxx25QLn3YFCYUx5XcM0Zn6n16KCiniCGPLK+gauJp8FGFcHY4wXeYilLFnqiE0PwushQMoWE7Y1i+mRJKOR5gxv8Lgr6TPC7CHRDQh4NH2HPTkqax5qS+Ynkv5OkbuV8mb/m6pf4aO7UGvU+dmPmLxxRXNzNo45QYyG7OI62QyuWdZF9elJKOcrHalwWyqtoSF3bwxidFQLsDn295F/PB16AtcYkv4GWrO3oaskwGB20l7ORgw45lVscCDpe47gwYm0/ROgevCJLyue6ivzKOI9Pvt+S5B05oq10F8+XE0tJbuP7GhO+G1KNFLrH5F0lLqSYM1YtQqHjt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v10 03/10] admin: introduce group administration commands
Thread-Index: AQHZTQeefL6YcT/2+0WEizoMfiOaWK7ny5BA
Date: Thu, 2 Mar 2023 18:40:29 +0000
Message-ID:
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
In-Reply-To:
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5335:EE_
x-ms-office365-filtering-correlation-id: 392e1caf-9fe3-4121-38e1-08db1b4d98db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tHaLwa6JIcZ/T53FsdsgGh26zIgWsaXIRrxpeR1oCcW/452DlR1DldPq4qt3znD8AhkGm4MorifBO7XhGz5zURda5ctbSP17WYCQ+mBYocMaBegKkYSQ99Z2Dz8Kjllmfvr8SN6Cf/DgqgrNDR919PiOqJkCurlXG7EmfVs/NkfR7+zBEqRRj5+UsIfMb+5lBN/Fn6SRAdcBMa8V7YFHK8FOLwUHjuqXL+JCemEz78idr0Dwn72aEv5A8ntAu6yAvm9bwYI5/JTiEFRuyiCYQ+uzph1+zZG8ti07PCUIrehH0b5B+VdiELX/dciHGpFzdjgn4nu/5/cWEFj6WKARBY7ZJZa4brnEYGVf3ekjLpy96jkb/SwZQp1in0JGVBTxY/i1eKdzfKJ7A8yLmn3bAseySQK0L06TLwlYpZlODMO/z3ttWIHudVOIkhXwxfCLO/72hL6M4j+DzYQIu/DSwRrcpZDeobwybqaZZtSGHJHS0mHGCNJWdSLIzdc3dwH0NqsmQC2SmemDobLYClXZjXPTXkxCCgntFLvCgXD5AU52NOewel+vxhtx8qqYn+ihF1kR2nGYxNiV0atLAN0wv4KYD0wb7a1Pvv/RHG90VTfAiw3nCDykc+DX0rmEHYrASv8LnygTMdyF2DrXKQ2oYbw+hR0B/bgzNdR73BCT0MPxCuY+uzCrU7SLkSeMpEk905X8hKcxnkZB/GepFba4HjTtHDjd7jCEaQXhIfz0DGM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(83380400001)(107886003)(38100700002)(122000001)(5660300002)(52536014)(478600001)(7416002)(921005)(66556008)(86362001)(33656002)(38070700005)(55016003)(8936002)(186003)(9686003)(26005)(6506007)(71200400001)(66476007)(64756008)(2906002)(7696005)(66946007)(66446008)(76116006)(8676002)(4326008)(41300700001)(316002)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KKxvrrlaL9unA70JJTZcem6LMXRx+45OmT292mEoJAjYQLlyT5qWRi33kGuk?=
 =?us-ascii?Q?U0IjsTBaMGu8MKGJ1lDDQm19nslFbxgPy93VpUQ3z5O3p+rgxNsrUwy4U3/D?=
 =?us-ascii?Q?kd0XORZzAs4ikKbMHAaiA68aKTagR3P2T8KYTHdovB7rZvLSGttqhXyT65JK?=
 =?us-ascii?Q?UI1tG2WEydd/DO5rVb5huYC5Oih32p4WKgon2jGNNkL+bD/MzHsaIQLLLN1l?=
 =?us-ascii?Q?frbGjVI2FkbrRU994OtXZqxj+EW9VKMITCBAO0B7/du+ZZoxB/EbvyTZh5GW?=
 =?us-ascii?Q?SYRIVgNmqNqDexWyf8QnuuVi8LdaBj50nCvDJ/hFE1IAHg1588eH2iu2EqMQ?=
 =?us-ascii?Q?D5TyHrEbRgfHA9wJGu8TIyVWc7Zg+Icgo0UT0OROAAphdc/95ARwl32oDgoO?=
 =?us-ascii?Q?U5pEkqR8zh4DYThSCllCse/KhwAD+zdjWeE7VS2DfGucPXYjylWVgQXpB4aQ?=
 =?us-ascii?Q?Dn1NLmIVlRJOH6lJKN2Ba0GakCECV7YKA/651qGUM8pGqHjqjao+3fzn6q8N?=
 =?us-ascii?Q?/9gYmZzsqXaOrx2a2aQFqgzLd8LFK2z7e21M2t+nHmkssF/InHAGGdTVT4+7?=
 =?us-ascii?Q?LyBf2hauWP9GDv7samIOEgzpljPDVXnJsENoPEmA7GtIdKCmL30127Eu0Rez?=
 =?us-ascii?Q?qamYpsL7XTHG+OpTr2PBOPL/oDSjCUXppdPg3sBoRHDScewngwTorc016ys6?=
 =?us-ascii?Q?hZ9mjc0toUEa0bOilVuh5kkxNIly6+a91v0xf2mDl6Rspv0OmSmA+kQDofwm?=
 =?us-ascii?Q?DlN8s2W3YQuGlA+DAAC+YKKGWbV2/8hBPXIDS19Yczbl1lJjozGKoFfw732k?=
 =?us-ascii?Q?QCSg+j6u5h4kGo45KhHoqAfUzX93QsmFw4Xfm1KEAo+tmXGbwF+8JhaOPmOs?=
 =?us-ascii?Q?UNySCTtZH85qdPAW+pKj/RbytmE2WUa2HvhHLaM+E6t32z85XHFP0x85sttZ?=
 =?us-ascii?Q?DnhAiCyjKj7oWE190nmUxk/w4BnDxb4YG5FOKci+RJJYaI4AUd+jDCOrjTPL?=
 =?us-ascii?Q?JMRlAbTOU3TscJsIPQo+buwXdgfHkmXKq89+QqVcKgYNl2FHPPP0qOuMovAA?=
 =?us-ascii?Q?ugUS5S4QRhBAS5GO6ISvDiU8XA0VzbKcEYhmOKd49Ivq2b0KUC6vjGrdOr8B?=
 =?us-ascii?Q?de4fZUmngvWThCZWEEkPSzQn+oe5d1Mwdr+7v8DGR2ycdGbl0GqMOfpOwyXR?=
 =?us-ascii?Q?ya6IGgU7Yz1+5gZOYwRZPNvowhTy9vaT0kOv491BSVdzJCNztuceyzuheboO?=
 =?us-ascii?Q?iqEDWMVvHon4RE7Nrv2piCsUTOWZhxORJ1E9/zTXNXedKjKRj1iL0Jm+nmxm?=
 =?us-ascii?Q?igQ1SCDYZUs64hsH7xf10PUh5696xi1Zg70e5aEazt2ZHJLRwiJVjKzHudIH?=
 =?us-ascii?Q?bCTHs4dVb0m9JIAYL/v35aFNcdvV58QYHR0w7DGBELVxlhpvZhLLqM6Cf35B?=
 =?us-ascii?Q?dV4vuDN3S0l0O3WEuMofLeICCZbnPzfHPIqk20HzMfuWt5CPeR+BjCiD/Jaa?=
 =?us-ascii?Q?AaF1Vd1NPMm1Yel73uthAksTBYgPVJ7ur76dGGRbcaPgZvs/xgH8BbiVACF2?=
 =?us-ascii?Q?PtVuymdtequP8CIRvYA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392e1caf-9fe3-4121-38e1-08db1b4d98db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:40:29.3680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmqtuepPz/9PzxrGq/ydkHP7qVZDdERGvyblQVxvxzMb2ZYAKBBEVlhOwgEA3H9ZFQSE4/9ahmt3QGp4eUt1tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Subject: [virtio-dev] RE: [PATCH v10 03/10] admin: introduce group administration commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 8:05 AM

> +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
> +is reserved and set to zero by the device.
> +
s/status_qialifier/status_qualifier
Missed from v10 of Feb.

> +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following table
> +describes possible \field{status_qialifier} values:
s/status_qialifier/status_qualifier

Can you please add other useful error codes in addition to the EINVAL?
Few that we are needed EAGAIN, ENOMEM, EBUSY, ENODEV.

And with that, VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER moves under ENODEV erro=
r code.

> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status & Name & Description \\
> +\hline \hline
> +0x00   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command
> error: no additional information  \\
> +\hline
> +0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or
> invalid \field{opcode}  \\
> +\hline
> +0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or
> invalid field within \field{command_specific_data}  \\
> +\hline
> +0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or
> invalid \field{group_type} \\
> +\hline
> +0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER    & unsupported or
> invalid \field{group_member_id} \\
> +\hline
> +0x05-0xFFFF   & -    & reserved for future use \\
> +\hline
> +\end{tabular}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

