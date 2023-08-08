Return-Path: <virtio-dev-return-13496-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18027C04A94
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:35:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ADE7245B3F
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:35:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FB8F986866
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:35:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF171983EB3; Tue,  8 Aug 2023 04:35:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B22F0986460;
	Tue,  8 Aug 2023 04:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDyGFQVOvvraXs7DcjHRTHtc3LM3ywxvvMxI7HtsavIIV2/xKPmd2As2jDl8+3G4lZNHLUw9pBt1UUZKGla2ZAb8X56eFXMjQLRBlmIrQVxjf8nO+s1BxH1etYye0DGXfKYmrNY1pwVw7d9LyUON50cM2fJycOVQ5xtZSNurxMIqtoA9PXVysNbt8gz69zJeMKnb2zVR7KIu3ipnjzebJw85ApjZKvl4uiA/zdM+uRYMDuTL0GL/9FPhfCZF2bn/NrJZ5YzlRXJJ4TBScvHgyhLpJ9dty614ckBYG9Kl66gQmluHb6lJxCOX8f5TWT81UagW/mP+vqC16R3NefbwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPw8qox+/GzsmgBm+QlRCV0SO6d/g/nRktdAmIVBDUY=;
 b=CRGDFkfOMAnMWN9H0o+GACtoHlW5Lbb35EeM7eeNuUNSx3A76S17fuqyaw42L6X3YpX1Ke7W6jaJaUi87V2cPoxOqYB8g8vQLIXgYunimMo8uRNxYedYdbo2u8TEsSOVXmwfZilfqK61LLoafYVWfKyuIZuuDFkOjfJy3QuiJk3rsTdgBS6hnkv2pjwklLE7UQq+/7boiCfgIQVNlpBQYZq1S1I/1PNGPFMbqHjTERy2WmSNp5mJk2Lfdekw/2+cYtvPkt7GfFuPjviWbL945fw2MgY4aURWTlcDcoLD7rzn/xzgXD07GyyiRll6cnXBTY+QBr+IueniQmDdoS+dpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: RE: RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAAgAAHcYCAAAfd0IAABlWAgAAvCwCAACGFIIAESeeAgAFTlICAAAUXAIAACRuAgAABk3CAAAzhgIAAAgIggAACfoCAAARNoA==
Date: Tue, 8 Aug 2023 04:34:18 +0000
Message-ID:
 <PH0PR12MB548149C76AE6EA7EC7C93AE8DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691388171.3192031-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtKcmvBqSJac4aNQMtvE+fYnOeLxeeXz1vtP5d2PM69bQ@mail.gmail.com>
 <1691462188.324996-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEszg7nUNH2bW+EQLVxnPvUzT66D8=V8x7JKw+DL=RzsiQ@mail.gmail.com>
 <PH0PR12MB5481D3BDFB943D7856D846A9DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691467247.671468-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54813D793F8BAA9D6614FA78DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691468213.0926805-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691468213.0926805-6-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB9126:EE_
x-ms-office365-filtering-correlation-id: 4465fd58-3133-4471-7e03-08db97c8bafd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3gw/jZriP4gI6+Whx12LRDjSqngr9c3ac9qXWSlOykT3D7Qz/ChXwMpUxK0P0FRReZbv3mOS9QI7GSlAGXmV8YlX+ScF0vgNsbS13AZ8EiXmu2uyLUCBaVM0sxKtycLL8HizT8pQ6vd2tk5RWpliV31XwIOECWgajWIaQXarMclSKdYENZEy/LWcV6dyt7fOJESYeZ7LEXgw6D+3xVwTmplDysyy4vRP4ZE4w+LI3Nz/NhMORQlrVX/HLMaMFEJMsTdVh/DD1X3QNqsFePaVx1T8I5+mtPR7oAc3ddguqlrUVzrn3zAKHVo77neVsAP0O3eD/zMrywTtJwSzaCz7mflx2ElS0wvRmF5zC+qpqAwlg/iPSQbbf2yPVzrSLuUO6SBF2VK6V/yDHDw8bR3zI3Uq7K7UzMd29Ckg5ZU1xZzCLRgf4JtVOmb2E/aknRirNc/KUHzNTHI6uw2qeQPkdu8Gwn7FgJs7w38QW5gGB62CrqOuJnolcgkwF/WYBlPgYFXRaoT+nlsPuRYq8w9Ei0h6oeZhfIEa7BSVb4csZMOe+dt+wWpxjkElDfBYuestbgzfRU/n40+7koSvDCiDqK+R7VOOh4vIYSF7jtIeMbt2EVy1R8OZEN3IbuO57Vcz7CNAMGiUK+Whz+ior2jKP08hrRs1sPR6phiPTBTqHm50b/UK2au2hntruZZmNtQ3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(90021799007)(451199021)(1800799003)(186006)(90011799007)(86362001)(41300700001)(52536014)(478600001)(6506007)(8936002)(8676002)(26005)(38100700002)(7696005)(4744005)(5660300002)(2906002)(54906003)(71200400001)(38070700005)(55016003)(316002)(66556008)(122000001)(66476007)(64756008)(66446008)(66946007)(76116006)(6916009)(4326008)(9686003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NJmVqX48qKZ71OXkke1GP93LVRdAMEDU0XF+KIzBniICBn0aGo2+HtVA4wBw?=
 =?us-ascii?Q?4/DG8ntWcUnwTc+E8GvDC1qzaAC/dYJbAV5QwbqWe8WzpcjQjDajFIZhWMO3?=
 =?us-ascii?Q?Xed8mRUVxwLLIFRQq4z/b3fkOcFDSmNeYlCLBnzk20VSxruk3xS3VvZtYq65?=
 =?us-ascii?Q?bSR0jdA9NWPxbyZAIYit6ZPAVYRrxmn8m/8xr3g9jScl1Co7j2eo+Nhx1lxf?=
 =?us-ascii?Q?fF+pLMzrNMQGKmmSCwaKfhJ5It0GiaigA44iVQfxZM6ZXoChAbSYP2m2yJix?=
 =?us-ascii?Q?Mq0SKagBncB6nhdg9CFnMjLCrpM2hWofDBsut5DPcBKqovng7tjeLcWzow/X?=
 =?us-ascii?Q?YjJguACgRRNq7qKLbnSPzWu8wMqJHmfRWxNWR5cMdNuMlUVVDljLlEp9pqWA?=
 =?us-ascii?Q?ECEpNrIWka9PsPfwyR9l8gB2+bFvZzGxQ1Rb1bUO8b0Bj37RK12JzqAkpp3w?=
 =?us-ascii?Q?DB97GrNWvhQ7nLTwGC/cnJUcUc99oC/+FG9wMMLbuFJYkhMZQy0zLDKfz+VB?=
 =?us-ascii?Q?mhGNbIp+TdXvu0Sl0pI9DOVtK5mB5UIBYPzed/1Y/cnva1Pe4yIR2OOdWsmz?=
 =?us-ascii?Q?OlPLUwf/mlH9aAhG3UY2CW/+y8affbF+FbVxpssRciUhJ3W9Yll88xmwubeN?=
 =?us-ascii?Q?6wD4JDswb+/1WP8euT0cjz6ZLFdeuxrcmP4pfP+UNee77IVuX0skUkUJ4m3r?=
 =?us-ascii?Q?200qUCg8D0qm/mH//oIDvqaO2QNsRlAWJPgOKrWICKlERB73gckmUU4zGyb5?=
 =?us-ascii?Q?NSZmtdkFVw+UCWXUGz5cSAcCTCIAS+u9beMeQLEU++1ON7rHPaW/ZIw4kQQX?=
 =?us-ascii?Q?CONDBq6ow3rOs36F7VKGdQ2ml9LRYoPPq4k9eYQanWNPyYGH1F9Md91VWgZd?=
 =?us-ascii?Q?m0WW8onYxMTi9m+4u7m5sVSnuQMkx/VQDwEkyjqNYBPzQq4IsAjPmP6ossdD?=
 =?us-ascii?Q?f75qE01DtifNNsnIcnQlYdQ44KE9jdPZ/wvScm2M0hqOlnV1href5Wi7FW3E?=
 =?us-ascii?Q?RjyeiqNwufKBc0VPMjraDjKqKPraneazGiL6FiHtOHH+Dw9P0jkVE2uqKNd5?=
 =?us-ascii?Q?hZV8TODaB1Lf+AKGI59mVEH+SR8tfEVdqmYh11Sg5ugOE0X63zwerkWz/z4s?=
 =?us-ascii?Q?L97gz63BrgDERL9QQANgCp6ou3SDhzqbCHsvNBGuMCMMurGPNFw7M12eRqza?=
 =?us-ascii?Q?zyi9/teVL8HEZQYfNXESeoLxgzydCBL0iS1dqceGlDM/CIcH4LVIPhRTlLPh?=
 =?us-ascii?Q?w1dIQq1HP2tYrGmaCupze2VJx1MJYrZ9IhTkxidlQL9zNC4uEFuHj5oHWxVZ?=
 =?us-ascii?Q?Tg3oWy8tCncvrcT/YYeUIC5GTnkOlWkRHRPx2I7rUAxzKGs4PZEr2fmDsfs7?=
 =?us-ascii?Q?VEFlPfmucNge2/HgzNQ52/1r5uqaZvWmwIQ589dkNhOHV7oSIfJIHZlNxaiI?=
 =?us-ascii?Q?LDAsv7ViNh7ZzNQ0kxq3QuFzHZEeRpuIg6oUrpgG0IFEMlxZxoP3SH0v+k3u?=
 =?us-ascii?Q?f0IeMfQMUgvLQEosAw9Rl367GsMp93jDWdo4yDvKkm/IdTTSH3NMOcrcwdHq?=
 =?us-ascii?Q?f7bab/4cKPaqK5JFl5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4465fd58-3133-4471-7e03-08db97c8bafd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 04:34:18.9134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyUnzlTaVDNiTsnR/6kONLHJqER7r5oEzLGxn8ypFMH5JEJ4mFhnUOQly/p3Hhk8C5/M5pWxataXn8WphZil9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
Subject: [virtio-dev] RE: RE: RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 8, 2023 9:47 AM

> I don't care whether swtich is introduced or not. Because we have no
> dependencies on it.
>=20
> My requirement is to implement ip restriction which is very important for=
 cloud
> scenarios.
>
These restrictions are needed for PF and VFs both, so can this be implement=
ed outside of the PF and VF in your environment?
=20
> I think the gap is, I don't care how it's implemented. Because for me, it=
 can be
> supported by switch rx, tx filter or virtio-net device. I'd love to hear =
everyone's
> opinions.
>=20
One proven model is to have virtio-net device to have switch object that ex=
poses flow filters capability, if at all this is needed in your env.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

