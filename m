Return-Path: <virtio-dev-return-11707-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF970C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:23:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 032322AF8A
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:23:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0C679864A8
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:23:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E6E9C986451; Wed, 22 Mar 2023 16:23:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D37DC986450;
	Wed, 22 Mar 2023 16:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEqhG52EcXR3uY7eK+NNu8wJEbwHGHUp03UN4vW41tuEVoPEFyjCbc01OkziE6bjAS7Kn4haJtxx87yERsG3F5JvtURfH7ZbWu191CJ2oDujGJh71IYwF6QPYLteDizy2ZtPJovG/26PAEL/MiUSUXEBAPVrc/cfWojXx8GFwtTpM1XBOuJSubqsoW4TC29rsz4ZwpPqVpenCFZalmar+QxvWY2qW2HmNAUnFpwYkBRVyJXRdwuCZgM9N1JlZJSm38bzlYnfw5Y7lsxIJVfaGhu04IchO76+sETlYrpEeYDk99vAhkx9g697LyAAm1taDzHLMlEzAMbTzX/FlEyfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nm4xZtMmtDL5CWtGk+PYhUj8XuICkKolWxyjy7XSrF4=;
 b=aMKMYgID9gJNS9F1nzACx+NN5Fcpl+6E8GwUa4DCWXBXgBd3M0Bw3EKzDCKLMPMKI0WHVXUa+0FioFeN2u1nPS3Hl2k8NcZRSKna7BlnDPbFFOqrptgrmi8Jd+QxENJ9k1aM+HnZmOMOHnPcWb33MXzFdJXCtK/ozitp3E+7XSl3SqXe/gJ7CoQQSg4qgu2raJ4k1fEH4xzY5err8BqPsBOXF7yND8NsZYlvZwDAzeO9l4AcMMK7Nn4Csz/C8dLBo9aKdDOaxD5UeaoKxFaPTv29R25+1V+AjQWH/MYyE2TevV+8V3rMji/nstbGeNjP3fbS1SclKlIirN0QbCOYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson
	<david.edmondson@oracle.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [PATCH v13] virtio-net: support the virtqueue coalescing
 moderation
Thread-Index: AQHZXL0YQHWs+6YDyUK7u3Kjjs+HRK8G6jaAgAAQ9sA=
Date: Wed, 22 Mar 2023 16:23:48 +0000
Message-ID:
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
In-Reply-To: <87sfdwhkxq.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB7845:EE_
x-ms-office365-filtering-correlation-id: 57e12a5b-80ea-4bdb-f953-08db2af1d14f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fxHk8XM9FLkSEqly0LGIqhJjY9qImH/x+rdSwFw1VBfIhjezmR6c0yBUes2pa3ykg7L5mIjXwYPA3ukzQ/2NSOnBSLkZS8We0JnfFv6X9J0suqT8VMlfG8Oz/Y3UeNANfWEO9WdqzOtq0V4f49kMqLLdDh/t8wzODnygPBx+hn8+CVahg6hjcIaTHVem5eWdnBpgwPFsZrJ9/PD1t2Rfxae6kxPQDdwGHVadBoZ6KYBjQicmiDRhiGynNDK2dP5y0SeYRRBEoSIUoSTn7mAwAyqTtBiABwx/wLrANal946uO+leuiIotiSs2Pb8gsvb/gORyo0Jn67H9SPixGntRuPdD7aD1r7U9cmYL1xSHzJM1A9cTt3YIUxC9u4Eu7jyPktiKaRgJ8waD+d3tEthkLtbeDnecw50j9D3qXAzQ6XE9j4cCKgD01WP2Ia7untuqpJ6bHFmVXgdRe/cA9KQ1sJd6j5L6uuiEO2z1RTCQg9OyJSfNFQSXDDG9wtHeu9Pd+7jjntx89+0XtLM+fNvYvs22W+niLDTyIKw8mmNhA59TB7Nr03okfHygSmdA3zZoKl8Btem3G9jG0qUsSUgie3Yhe9AhVjzlkXCIW+weNmCaSlU1ge0mFtq+mVwuSWQx3JDKYZ58ew1VDQ2sTKs5aagIYGG1rwxNL395OTwhSeO/tvb1qgMUDsS5FPGrQdS5NYfVd3k8i7Iw13Q3D+NRGg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199018)(33656002)(38100700002)(122000001)(86362001)(66556008)(38070700005)(41300700001)(5660300002)(4744005)(2906002)(66446008)(64756008)(8676002)(4326008)(55016003)(66946007)(8936002)(66476007)(26005)(9686003)(186003)(54906003)(110136005)(7696005)(316002)(52536014)(71200400001)(6506007)(478600001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?APydQq0KipG77iRtR+DVZLHIpmXEvAdZqFEcMu4Yyz4Et2XblRIQ5gZoT/eT?=
 =?us-ascii?Q?TXIMt9w/KO0BZVwHbzi3Rs97Qu8Buo30HPPsKziO9CQdd0b/bYvL7l3U9pxh?=
 =?us-ascii?Q?1hWA8Tn8WhBACzrBXLMtYKdlnS4tfklnufAqehW6d0Wa0ehopBv3evO9fXWT?=
 =?us-ascii?Q?aKokb+FOnAWbtF+q/UHnGQ8eAVOZuDAxm74BOOE4QNIUxRdCKIv0ok+oBU95?=
 =?us-ascii?Q?zjh2UM+/NLNwC2g7qPlXpKhiIsae3tSQAkKSCQSqnFR607/ToV16ULhZ6Rdq?=
 =?us-ascii?Q?xjUEW4AvN7oinoSO1Zw8RgBq9NdlXmWGQu+X05XknjgAjXl9sG4ASTdt0qhF?=
 =?us-ascii?Q?FmDFZ5jDHzWBizGHf7QXsFXyvIrUU/bzHL+ToGcEftptVUAtoaukD4Z72ObS?=
 =?us-ascii?Q?VZX81Q+T0AxvLokO9zA3X/SKx/0zOFGPkP7HGajh5wWf0tAuGmu7GXTYQ/xG?=
 =?us-ascii?Q?yAo7wo3PVM7qcBiyUdXZKaHAXyJir1YbaxC6alTwvWFi2YIXi4Ei+i572Vlc?=
 =?us-ascii?Q?QYfOyDXL+p9RZwwSULfwKqylt//NBHXDxYpLnYwE2UfPFuDRto4n8cyCHwmY?=
 =?us-ascii?Q?3Wclk293+H8vLmQ5lGkK9gAa60L9cCJehxNzEbjmrAXdvrAVJdnp6PVeX5cJ?=
 =?us-ascii?Q?6rtncj5kwWKqOnxVW6c02Twxr1PIy1+rWJn9NwUNT5qQMLfsV2xh/Ho17hX5?=
 =?us-ascii?Q?6BZgMm1sOy18sNqiwNe4tgh6DD9o1Zo4/ncDw9f9bKWymEsfp/iGMWIAFfb6?=
 =?us-ascii?Q?2kcuCl9mzVPwLPH2gJArpoRWm83ODyxH19xrrSeEwrXmHH/BEcIMfL+cHK4E?=
 =?us-ascii?Q?rSRKhGyOQDnF2T2yHv0tgPKigX7hTg0eArwG4hArmv0Q0XAE4uKVtihEmM9E?=
 =?us-ascii?Q?6Nm7F97pPymj+hW/7mFKaZG28/B8AWaue3rA7ac9GMBvt+YK/gH5Uwi+gZzl?=
 =?us-ascii?Q?t8Mwl9bQbKLAvL6ytQ1XmEPn59aRgQSm783PsoITeTMr7KOFL7+/dcOProbP?=
 =?us-ascii?Q?WTdEKy2zQ4n++o5C3IbpJ7ru+TG59GlEK+tcPsYoCU5L0X7uMKrNZrS1YeD1?=
 =?us-ascii?Q?WfUwlavpHwsoPamx8HZ+OodIsUyZiKs+Crz+NT2uBscnfyMq/0FKyfgGuvbU?=
 =?us-ascii?Q?nP9MaBlDFunxyHk8n2sscPvwyhN+JGjLeUkOxY2KudqeQImWztlLa3dLajcW?=
 =?us-ascii?Q?kadCNP9Ag/n0FryEh2LoBY777gR7sNsiynvEJbWpUfUtR61rI/kKtcw9WxcO?=
 =?us-ascii?Q?uJ98+b8GXhvRK4JinekWaIc8HrAPWgjbQns8cHuL5DXJoea+Vry11c1TYN18?=
 =?us-ascii?Q?otrVMyH8YJa12uGlci1xd6RWXaSqZ2SSx+D6Qd+RtybQ3ERFpmec08j4tKhM?=
 =?us-ascii?Q?oPvEoIOrWHhGMGCqO2EyEih/lV5njVZeQJfIkCai04TxbqJZJKiKnH+ToP02?=
 =?us-ascii?Q?3j+AKRzrjblspB/acEGiSPpIBGn8nhpX5pyJsJBWDdJoKUvuck3VLAdk2gzr?=
 =?us-ascii?Q?Bzqy5SyRmP6d2+Zm7uKB+zisvW4wRRHRmxJlCKv2eurWnqcBXcjyCb0WpIzB?=
 =?us-ascii?Q?RfJ5/fMqdXybhHngz9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e12a5b-80ea-4bdb-f953-08db2af1d14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 16:23:49.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYfWwB/5ApBiR6+7fOcjUqiBcLK1PbwX10Qx7SGlVpmTfKLxJD4c93MPQ8JlVRYn0ITbaK0t09y3kB52fEg/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
Subject: [virtio-dev] RE: [PATCH v13] virtio-net: support the virtqueue coalescing
 moderation



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, March 22, 2023 11:21 AM
>=20
> On Wed, Mar 22 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
>=20
> > +The driver MUST NOT set \field{vqn} to any value other than an enabled
> transmit or receive virtqueue number.
>=20
Why do you suggest a negative statement here?
How is it better than,
The driver MUST set ...

The device will anyway have to check and apply the parameter to the right v=
irtqueue.
And if the vq is not enabled or vq is not tx or rx vq, it needs to fail the=
 command.

> "than the virtqueue number of an enabled transmit or receive virtqueue"
>=20
> might be better -- what do others think?
>=20
> Otherwise, LGTM.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

